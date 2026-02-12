{ lib, ... }:
{
  time.timeZone = lib.mkDefault "Asia/Taipei";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = lib.mkDefault "zh_TW.UTF-8";
    LC_IDENTIFICATION = lib.mkDefault "zh_TW.UTF-8";
    LC_MEASUREMENT = lib.mkDefault "zh_TW.UTF-8";
    LC_MONETARY = lib.mkDefault "zh_TW.UTF-8";
    LC_NAME = lib.mkDefault "zh_TW.UTF-8";
    LC_NUMERIC = lib.mkDefault "zh_TW.UTF-8";
    LC_PAPER = lib.mkDefault "zh_TW.UTF-8";
    LC_TELEPHONE = lib.mkDefault "zh_TW.UTF-8";
    LC_TIME = lib.mkDefault "zh_TW.UTF-8";
  };
}
