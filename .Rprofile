#
# RProfile for R Startup
#

#
# Disable ask on quit:
# Source:
#   http://stackoverflow.com/a/4996252
#

# Set hook to be run when Defaults is attached
setHook(packageEvent("Defaults", "attach"),
        function(...) { setDefaults(q, save="no"); useDefaults(q) })
# add Defaults to the default packages loaded on startup
old <- getOption("defaultPackages");
options(defaultPackages = c(old, "Defaults"))
