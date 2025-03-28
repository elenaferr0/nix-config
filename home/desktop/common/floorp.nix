{lib, ...}: {
  programs.browserpass.enable = true;
  programs.floorp = {
    enable = true;
    languagePacks = ["en-US"];
    profiles.elena = {
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        order = ["DuckDuckGo" "Google"];
        engines = {
          "Bing".metaData.hidden = true;
        };
      };
      bookmarks = {};
      settings = {
        "browser.startup.homepage" = "about:home";

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

        # Do not ask for download dir
        "browser.download.useDownloadDir" = true;

        # Open pdfs instead of downloading them
        "browser.download.open_pdf_attachments_inline" = true;

        # UI customizations
        "browser.compactmode.show" = true;
        "floorp.browser.user.interface" = 8; # Floorp Fluerial UI
        "widget.non-native-theme.scrollbar.style" = 3;
        "apz.overscroll.enabled" = false; # No overscroll animations at the top

        "image.mem.surfacecache.max_size_kb" = 500000; # Img cache

        # Tabs config, disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.activity-stream.floorp.newtab.imagecredit.hide" = true;
        "browser.newtabpage.activity-stream.floorp.newtab.releasenote.hide" = true;
        "browser.newtabpage.blocked" = lib.genAttrs [
          # Youtube
          "26UbzFJ7qT9/4DhodHKA1Q=="
          # Facebook
          "4gPpjkxgZzXPVtuEoAL9Ig=="
          # Wikipedia
          "eV8/WsSLxHadrTL1gAxhug=="
          # Reddit
          "gLv0ja2RYVgxKdp0I5qwvA=="
          # Amazon
          "K00ILysCaEq8+bEqV/3nuw=="
          # Twitter
          "T9nJot5PurhJSy8n038xGA=="
        ] (_: 1);
        "browser.tabs.insertAfterCurrent" = true;
        "browser.newtabpage.activity-stream.floorp.background.image.path" = "~/Pictures/wallpapers/browser.jpg";
        "browser.newtabpage.activity-stream.floorp.background.type" = 4; # Image

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false; # Disable Extension recommendations ("Recommend extensions as you browse")
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false; # "Recommend features as you browse"
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Disable addons recommendations
        "extensions.getAddons.showPane" = false;
        "extensions.webservice.discoverURL" = "";
        "extensions.getAddons.discovery.api_url" = "";

        # Media settings
        "media.block-autoplay-until-in-foreground" = true;
        "media.block-play-until-document-interaction" = true;
        "media.block-play-until-visible" = true;

        # Layout
        "layout.word_select.eat_space_to_next_word" = true;

        # Don't show prompt to save password
        "signon.rememberSignons" = false;

        # Identity settings
        "identity.fxaccounts.enabled" = true;
        "identity.fxaccounts.account.device.name" = "thinkpad";

        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 20;
          newElementCount = 5;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
          placements = {
            PersonalToolbar = ["personal-bookmarks"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            nav-bar = [
              "back-button"
              "forward-button"
              "vertical-spacer"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "ublock0_raymondhill_net-browser-action"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "_testpilot-containers-browser-action"
              "reset-pbm-toolbar-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = ["menubar-items"];
            unified-extensions-area = [];
            widget-overflow-fixed-list = [];
          };
          seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
        };
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };
    policies = {
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # "addon@darkreader.org" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        #   installation_mode = "force_installed";
        # };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # "adnauseam@rednoise.org" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/adnauseam/latest.xpi";
        #   installation_mode = "force_installed";
        # };
        "addon@fastforward.team.xpi" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/fastforwardteam/latest.xpi";
          installation_mode = "force_installed";
        };
        "idcac-pub@guus.ninja" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          # Bitwarden
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          # Return YT dislikes
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          installation_mode = "force_installed";
        };
        "custom-new-tab-page@mint.as" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/custom-new-tab-page/latest.xpi";
          installation_mode = "force_installed";
        };
        # "{6AC85730-7D0F-4de0-B3FA-21142DD85326}" = {
        #   # Colorzilla
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/colorzilla/latest.xpi";
        #   installation_mode = "force_installed";
        # };
        # "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
        #   # TWP
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
        #   installation_mode = "force_installed";
        # };
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "application/pdf" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
