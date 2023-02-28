{pkgs, config, inputs, self, ...}:
{
            inputs.ironbar.homeManagerModules.default
        {
          # And configure
          programs.ironbar = {
            enable = true;
            config = {};
            style = "";
          };
        }
}