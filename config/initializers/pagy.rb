# frozen_string_literal: true

require "pagy/extras/bootstrap"

# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:page]   = 1
Pagy::DEFAULT[:items]  = 24
Pagy::DEFAULT[:outset] = 0
