module Kuhsaft
  class Engine < ::Rails::Engine
    isolate_namespace Kuhsaft

    config.i18n.fallbacks = [:de]
    config.i18n.load_path += Dir[Kuhsaft::Engine.root.join('config', 'locales', '**', '*.{yml}').to_s]

    # defaults to nil
    config.sublime_video_token = nil
  end
end
