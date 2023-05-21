{ ... }:
let
  laptop_fingerprint = "00ffffffffffff004d10c51400000000091d0104a522137807de50a3544c99260f50540000000101010101010101010101010101010150d0805070381f401828350058c2100000181434805070381f401828350058c210000018000000100000000000000000000000000000000000fc004c513135364d314a5730330a2000e4";
  hdmi_fingerprint = "00ffffffffffff001e6d805b88b70000061e010380462778ea8cb5af4f43ab260e5054254b007140818081c0a9c0b300d1c08100d1cf5aa000a0a0a0465030383500b9882100001a000000fd0030781ee63c000a202020202020000000fc003237474c3835300a2020202020000000ff003030364e54504331433938340a014f020344f1230907074d100403011f13123f5d5e5f60616d030c001000b83c20006001020367d85dc401788003e30f0018681a00000101307800e305c000e6060501605928d97600a0a0a0345030203500b9882100001a565e00a0a0a0295030203500b9882100001a0000000000000000000000000000000000000000000000f4";
in {
  programs.autorandr = {
    enable = true;

    profiles = {
      "only-laptop" = {
        fingerprint = {
          eDP2 = laptop_fingerprint;
        };
        config = {
          eDP2 = {
            enable = true;
            primary = true;
            crtc = 0;
            mode = "1920x1080";
            position = "320x1440";
            rate = "240.00";
          };
        };
      };
      "home-hdmi" = {
        fingerprint = {
          eDP2 = laptop_fingerprint;
          HDMI-1-0 = hdmi_fingerprint;
        };
        config = {
          eDP2 = {
            enable = true;
            primary = true;
            crtc = 0;
            mode = "1920x1080";
            position = "320x1440";
            rate = "240.00";
          };
          HDMI-1-0 = {
            enable = true;
            crtc = 4;
            mode = "2560x1440";
            position = "0x0";
            rate = "99.95";
          };
        };
      };
    };

    hooks = {
      postswitch = {
        "restore-background" = "~/.fehbg";
      };
    };
  };

}
