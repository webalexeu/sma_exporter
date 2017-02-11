require 'rack'
require "sma_exporter"
require 'prometheus/client/rack/collector'
require 'prometheus/client/rack/exporter'

use Rack::Deflater, if: ->(_, _, _, body) { body.any? && body[0].length > 512 }
use SmaExporter::Rack
use Prometheus::Client::Rack::Collector
use Prometheus::Client::Rack::Exporter

SmaExporter::Runner.register!

run ->(_) { 
  [200, { 'Content-Type' => 'text/html' }, ['OK'] ] 
}
