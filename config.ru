$LOAD_PATH << '.'
require './config/environment'

use Rack::Static, :urls => ['/stylesheets', '/javascripts', '/images'], :root => 'public'

use BetterErrors::Middleware
BetterErrors.application_root = __dir__

use Rack::MethodOverride
use UsersController
use ArticlesController
use BookmarksController
run ApplicationController