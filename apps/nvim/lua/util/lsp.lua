-- Helper and keybind functions for LSP stuff

local lsp = {}

-- Only run the first time
-- TODO: Make this a per project root table
if vim.g.use_semantic_hl == nil then
    vim.g.use_semantic_hl = true
end

function lsp.toggle_hints()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

function lsp.toggle_diagnostics()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

function lsp.use_treesitter_hl(buf, lsp_client_id)
    vim.treesitter.start(buf)
    vim.lsp.semantic_tokens.stop(buf, lsp_client_id)
    vim.g.use_semantic_hl = false
end

function lsp.use_semantic_hl(buf, lsp_client_id)
    vim.lsp.semantic_tokens.start(buf, lsp_client_id)
    vim.lsp.semantic_tokens.force_refresh(buf)
    vim.treesitter.stop(buf)
    vim.g.use_semantic_hl = true
end

-- Toggle between LSP semantic highlighting and treesitter highlighting
-- BUG: Either this function or the helper functions create a bad state.
-- Toggling can cause *some* highlight groups in *some* **files** to not apply.
-- Is is the semantic token highlight groups that get messed up.
-- Not all the groups fail, and it seems that it is always the same groups that fail.
-- Running vim.lsp.get_at_pos() for the broken areas returns "{}", non-broken areas are fine
-- Only tried/observed in lua_ls
-- No clue why.
-- None of force refreshing tokens, switching themes, nor closing the buffer will fix it.
-- Only restarting the LSP fixes it.
function lsp.toggle_semantic_hl()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    for _, lsp_client in ipairs(clients) do
        if lsp_client.server_capabilities.semanticTokensProvider then

            -- HACK: Using private __STHighlighter to detect if the semantic token highlighting engine state
            local highlighter = vim.lsp.semantic_tokens.__STHighlighter.active[bufnr]
            local initially_on = highlighter and true or false

            for buf, _ in pairs(lsp_client.attached_buffers) do
                if initially_on then
                    lsp.use_treesitter_hl(buf, lsp_client.id)
                else
                    lsp.use_semantic_hl(buf, lsp_client.id)
                end
            end
        end
    end
end

function lsp.kill_semantic_hl()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    for _, lsp_client in ipairs(clients) do
        if lsp_client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.stop(bufnr, lsp_client.id)
            lsp_client.server_capabilities.semanticTokensProvider = nil
        end
    end
end

return lsp
