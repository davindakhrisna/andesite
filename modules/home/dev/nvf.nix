{
  flake.homeModules.dev-nvf = {
    pkgs,
    lib,
    ...
  }: {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.nvf = {
      enable = true;
      enableManpages = true;

      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          globals.mapleader = " ";
          globals.maplocalleader = " ";

          # Editor Options
          options = {
            tabstop = 2;
            shiftwidth = 2;
            softtabstop = 2;
            expandtab = true;
            smartindent = true;
            number = true;
            relativenumber = true;
            cursorline = true;
            mouse = "a";
            clipboard = "unnamedplus";
            undofile = true;
            signcolumn = "yes";
            scrolloff = 8;
            sidescrolloff = 8;
            splitbelow = true;
            splitright = true;
            termguicolors = true;
            wrap = false;
            timeoutlen = 300;
          };

          # Theme & Visual Aesthetics
          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = true;
          };

          # Statusline & Mini Suite (Zero warnings, fast & sleek)
          mini = {
            statusline.enable = true;
            icons.enable = true;
            indentscope.enable = true;
            ai.enable = true;
          };

          extraPlugins = {
            mini-base16 = {
              package = pkgs.vimPlugins.mini-base16;
            };
          };

          # Dynamic Wallust Palette Loader
          luaConfigRC.wallust = ''
            local wallust_colors = vim.fn.expand("~/.cache/wallust/colors-neovim.lua")
            if vim.fn.filereadable(wallust_colors) == 1 then
                local ok, palette = pcall(dofile, wallust_colors)
                if ok and type(palette) == "table" then
                    pcall(function()
                        local mini_base16 = require('mini.base16')
                        mini_base16.setup({
                            palette = palette,
                            use_icons = true,
                        })
                    end)
                end
            end
          '';

          # Tabline / Bufferline
          tabline.nvimBufferline = {
            enable = true;
          };

          # Visual Addons
          visuals = {
            nvim-web-devicons.enable = true;
            indent-blankline.enable = true;
            rainbow-delimiters.enable = true;
          };

          # UI Components
          ui = {
            borders.enable = true;
            colorizer.enable = true;
            noice.enable = true;
            fastaction.enable = true;
          };

          # Notification Popups
          notify.nvim-notify.enable = true;

          # File Explorer & Fuzzy Search
          filetree.neo-tree = {
            enable = true;
          };

          telescope = {
            enable = true;
          };

          # Autocompletion (nvim-cmp) & Snippets
          autocomplete.nvim-cmp = {
            enable = true;
            sources = {
              buffer = "[Buffer]";
              lsp = "[LSP]";
              path = "[Path]";
              treesitter = "[Treesitter]";
            };
          };

          snippets.luasnip.enable = true;

          # LSP (Language Server Protocol)
          lsp = {
            enable = true;
            formatOnSave = true;
            lightbulb.enable = true;
            lspkind.enable = true;
            trouble.enable = true;
          };

          # Treesitter
          treesitter = {
            enable = true;
            autotagHtml = true;
            context.enable = true;
          };

          # Git Integration
          git = {
            enable = true;
            gitsigns = {
              enable = true;
              codeActions.enable = true;
            };
          };

          # Utility & Keymap Helper
          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };

          utility = {
            surround.enable = true;
            motion.flash-nvim.enable = true;
            diffview-nvim.enable = true;
          };

          autopairs.nvim-autopairs.enable = true;
          comments.comment-nvim.enable = true;

          # Rich Multi-Language Support
          languages = {
            enableTreesitter = true;
            enableFormat = true;
            enableExtraDiagnostics = true;

            nix.enable = true;
            markdown.enable = true;
            bash.enable = true;
            lua.enable = true;
            rust.enable = true;
            tsx.enable = true;
            go.enable = true;
            python.enable = true;
            html.enable = true;
            css.enable = true;
            yaml.enable = true;
            json.enable = true;
            toml.enable = true;
          };

          # Intuitive Custom Keymaps
          keymaps = [
            # File Tree & Finder
            { key = "<leader>e"; mode = "n"; action = ":Neotree toggle<CR>"; desc = "Toggle File Explorer"; }
            { key = "<leader>ff"; mode = "n"; action = ":Telescope find_files<CR>"; desc = "Find Files"; }
            { key = "<leader>fg"; mode = "n"; action = ":Telescope live_grep<CR>"; desc = "Live Grep"; }
            { key = "<leader>fb"; mode = "n"; action = ":Telescope buffers<CR>"; desc = "Find Buffers"; }
            { key = "<leader>fh"; mode = "n"; action = ":Telescope help_tags<CR>"; desc = "Help Tags"; }

            # Buffer Navigation
            { key = "<Tab>"; mode = "n"; action = ":bnext<CR>"; desc = "Next Buffer"; }
            { key = "<S-Tab>"; mode = "n"; action = ":bprevious<CR>"; desc = "Previous Buffer"; }
            { key = "<leader>bd"; mode = "n"; action = ":bdelete<CR>"; desc = "Close Buffer"; }

            # Window Splits & Navigation
            { key = "<leader>sv"; mode = "n"; action = ":vsplit<CR>"; desc = "Split Vertical"; }
            { key = "<leader>sh"; mode = "n"; action = ":split<CR>"; desc = "Split Horizontal"; }
            { key = "<C-h>"; mode = "n"; action = "<C-w>h"; desc = "Focus Left Window"; }
            { key = "<C-j>"; mode = "n"; action = "<C-w>j"; desc = "Focus Down Window"; }
            { key = "<C-k>"; mode = "n"; action = "<C-w>k"; desc = "Focus Up Window"; }
            { key = "<C-l>"; mode = "n"; action = "<C-w>l"; desc = "Focus Right Window"; }

            # Diagnostics & Trouble
            { key = "<leader>xx"; mode = "n"; action = ":Trouble diagnostics toggle<CR>"; desc = "Diagnostics (Trouble)"; }

            # Quick Save & Quit
            { key = "<leader>w"; mode = "n"; action = ":w<CR>"; desc = "Save File"; }
            { key = "<leader>q"; mode = "n"; action = ":q<CR>"; desc = "Quit"; }
          ];
        };
      };
    };
  };
}
