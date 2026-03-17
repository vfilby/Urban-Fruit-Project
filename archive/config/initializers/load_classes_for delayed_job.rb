# Any classes that are not active record based need to be loaded so that
# delayed job can instantiate them.

include BrowseCacheManager
