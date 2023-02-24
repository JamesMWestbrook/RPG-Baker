extends Command
class_name Message

#@export_file("*.dch") var speaker
@export_multiline var message:String

func run():
	pass
	#Until dialogic + godot are in a state where it can run without crashing the editor, messages 
	#won't really be a thing 
	


#	var events : Array = []
#	var text_event = DialogicTextEvent.new()
#	text_event.text = message
#	events.append(text_event)
#
#	var timeline : DialogicTimeline = DialogicTimeline.new()
#	timeline.events = events
#	timeline.events_processed = true
#	Dialogic.start_timeline(timeline)
#
