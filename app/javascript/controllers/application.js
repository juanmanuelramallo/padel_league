import { Application } from "@hotwired/stimulus"
import Clipboard from '@stimulus-components/clipboard'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
application.register('clipboard', Clipboard)

export { application }
