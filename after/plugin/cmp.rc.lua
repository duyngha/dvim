local status, cmp = pcall(require, "cmp") -- The complete engine
if (not status) then return end

local lspkind = require 'lspkind' -- Pretty icons on the automplete list
local luasnip = require 'luasnip' -- The snippet engine

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate the dropdown list snippet
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    -- Enter select the item
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    -- Use <Tab> as the automplete trigger
    --["<Tab>"] = function(fallback)
    --if cmp.visible() then
    --cmp.select_next_item()
    --print('Hello')
    --elseif luasnip.expand_or_jumpable() then
    --luasnip.expand_or_jump()
    --print("hello")
    --else
    --fallback()
    --print("hello")
    --end
    --end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = "luasnip" }
  }),
  -- Improve the dropdown list display: Show incons and show where
  -- the automcomplete sugestion comes from
  formatting = {
    format = lspkind.cmp_format({
      wirth_text = false,
      maxwidth = 50,
      mode = "symbol_text",
      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[Lsp]",
        luasnip = "[Snip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Lat]",
      },
    })
  },
  -- Show borders like the LSP autocomplte
  window = {
    documentation = cmp.config.window.bordered(),
  },
  -- Can be anoying so experiment with it
  experimental = {
    ghost_text = true,
  },
})

--vim.cmd [[
--  set completeopt=menuone,noinsert,noselect
--  highlight! default link CmpItemKind CmpItemMenuDefault
