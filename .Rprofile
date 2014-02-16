#
# .RProfile for R Startup
# Links:
#   http://stackoverflow.com/questions/1189759/expert-r-users-whats-in-your-rprofile
#

#
# Disable ask on quit:
# Source:
#   http://stackoverflow.com/a/4996252
#

# Set hook to be run when Defaults is attached
setHook(packageEvent('Defaults', 'attach'),
        function(...) {
            setDefaults(q, save='no')
            useDefaults(q)
        })

# Add Defaults to the default packages loaded on startup
old <- getOption('defaultPackages')
options(defaultPackages = c(old, 'Defaults'))

#
# Always use US Repo
# Source:
#   http://stackoverflow.com/a/1189826
#

r <- getOption('repos')
r['CRAN'] <- 'http://cran.us.r-project.org'
options(repos = r)
rm(r)
