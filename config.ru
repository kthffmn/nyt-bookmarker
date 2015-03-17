$LOAD_PATH << '.'
require './config/environment'

use Rack::Static, :urls => ['/stylesheets', '/javascripts', '/images'], :root => 'public'

use Rack::MethodOverride
use UsersController
use ArticlesController
use BookmarksController
run ApplicationController