local ls = require 'luasnip'
local snippet_collection = require 'luasnip.session.snippet_collection'

local s = ls.s
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require('luasnip.extras.fmt').fmt

snippet_collection.clear_snippets 'php'
ls.add_snippets('php', {
  s(
    'intf',
    fmt(
      [[
<?php

declare(strict_types=1);

namespace {};

interface {}
{{
    {}
}}
]],
      {
        d(1, function()
          local path = vim.fn.fnamemodify(vim.fn.expand '%', ':h:gs?/?\\?')
          return sn(nil, {
            i(1, path:sub(1, 1):upper() .. path:sub(2)),
          })
        end),
        d(2, function()
          return sn(nil, {
            i(1, vim.fn.fnamemodify(vim.fn.expand '%', ':t:r')),
          })
        end),
        i(3),
      }
    )
  ),
  s(
    'trait',
    fmt(
      [[
<?php

declare(strict_types=1);

namespace {};

trait {}
{{
    {}
}}
]],
      {
        d(1, function()
          local path = vim.fn.fnamemodify(vim.fn.expand '%', ':h:gs?/?\\?')
          return sn(nil, {
            i(1, path:sub(1, 1):upper() .. path:sub(2)),
          })
        end),
        d(2, function()
          return sn(nil, {
            i(1, vim.fn.fnamemodify(vim.fn.expand '%', ':t:r')),
          })
        end),
        i(3),
      }
    )
  ),
  s(
    'pfunc',
    fmt(
      [[
public function {}({}): {}
{{
    {}
}}
      ]],
      { i(1), i(2), i(3, 'void'), i(4) }
    )
  ),
  s(
    'ifunc',
    fmt(
      [[
public function {}({}): {};
      ]],
      { i(1), i(2), i(3, 'void') }
    )
  ),
})
