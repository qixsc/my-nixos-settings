{ config, pkgs, ... }:

let 
  # nixvim = import (builtins.fetchGit{
  #   url = "https://github.com/nix-community/nixvim";
  #   ref = "nixos-25.11";
  # });
in
{
  imports = [
  ];

  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "qixsc";
  home.homeDirectory = "/home/qixsc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fastfetch
    rustup
    typst
    gcc
    cmake
    gnumake
    ripgrep
    fzf
    lazygit
    (python3.withPackages (pypkgs: with pypkgs; [
      pip
      virtualenv
      autopep8
      numpy
      sympy
      matplotlib
    ]))
    dotnet-sdk
    tinymist
    ani-cli
    vlc
    traceroute
    linux-wifi-hotspot
    kdePackages.kdeconnect-kde
  ];
  
  # programs.nixvim = {
  #   enable = true;
  #   colorschemes.gruvbox.enable = true;

  #   opts = {
  #     number = true;
  #     relativenumber = true;
  #     smartindent = true;
  #     tabstop = 4;
  #     shiftwidth = 4;
  #     smartcase = true;
  #     hlsearch = true;
  #     encoding = "utf-8";
  #   };

  #   plugins.lsp = {
  #     enable = true;
  #     servers = {
  #       rust_analyzer = {
  #         enable = true;
  #         installCargo = false;
  #         installRustc = false;
  #         settings = {};
  #       };
  #       tinymist = {
  #         enable = true;
  #         settings = {
  #           formatterMode = "typstyle";
  #           exportPdf = "onSave";
  #         };
  #       };
  #       pylsp = {
  #         enable = true;
  #         settings = {
  #         };
  #       };
  #     };
  #   };

  #   extraPlugins = with pkgs.vimPlugins; [
  #     nerdtree
  #     vim-airline
  #     vim-airline-themes
  #     auto-pairs
  #     vim-wakatime
  #     # nvim-cmp
  #     # cmp-nvim-lsp
  #     # typst-vim
  #     # rust-vim
  #   ];

  #   extraConfigVim = ''
  #     syntax enable
  #     filetype plugin indent on
      
  #     let g:rustfmt_autosave=1
  #     au FileType typst let b:AutoPairs = AutoPairsDefine({'$': '$'})
  
  #     nnoremap <C-n> :NERDTree<CR>
  #     nnoremap <C-t> :NERDTreeToggle<CR>
  #     nnoremap <C-f> :NERDTreeFind<CR>
  #     autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
      
  #     let g:airline_theme = "base16"
  #   '';
  # };

  programs.helix = {
    enable = true;
    # languages = {
    #   language-sever.tinymist = with pkgs; {
    #     command = "${tinymist}"
    #   };
    # };
    languages = {
      language = [
        {
          name = "typst";
          auto-format = false;
          language-servers = [ "tinymist" ];
        }
      ];

      language-server.tinymist = with pkgs;{
        command = "${tinymist}/bin/tinymist";
        config = {
          exportPdf = "onSave";
       
        };
      };
    };
  };

  # htop settings
  programs.htop = {
    enable = true;
    settings = {
      show_cpu_temperature = 1;
      hide_kernel_threads = 1;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/qixsc/etc/profile.d/hm-session-vars.sh
  #
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
