require 'protovis'
require 'protovis_tests'
ActionView::Helpers::JavaScriptHelper.send :include, Protovis
ActionView::Base.send :include, Protovis
ActionView::Base.send :include, ProtovisTests 

