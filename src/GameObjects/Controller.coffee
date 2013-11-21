define (require) ->
	GameObject = require './GameObject'

	keyNameToCode =
		backspace: 8
		tab: 9
		enter: 13
		shift: 16
		control: 17
		alt: 18
		pause: 19
		'caps lock': 20
		escape: 27
		'page up': 33
		'page down': 34
		end: 35
		home: 36
		'left arrow': 37
		'up arrow': 38
		'right arrow': 39
		'down arrow': 40
		insert: 45
		delete: 46
		"0": 48
		"1": 49
		"2": 50
		"3": 51
		"4": 52
		"5": 53
		"6": 54
		"7": 55
		"8": 56
		"9": 57
		a: 65
		b: 66
		c: 67
		d: 68
		e: 69
		f: 70
		g: 71
		h: 72
		i: 73
		j: 74
		k: 75
		l: 76
		m: 77
		n: 78
		o: 79
		p: 80
		q: 81
		r: 82
		s: 83
		t: 84
		u: 85
		v: 86
		w: 87
		x: 88
		y: 89
		z: 90
		'left window key': 91
		'right window key': 92
		select: 93
		f1: 112
		f2: 113
		f3: 114
		f4: 115
		f5: 116
		f6: 117
		f7: 118
		f8: 119
		f9: 120
		f10: 121
		f11: 122
		f12: 123
		';': 186
		'=': 187
		'+': 188
		'-': 189
		'.': 190
		'/': 191
		'[': 219
		']': 221
		"'": 222

	keyCodeToName = {}
	(Object.keys keyNameToCode).forEach (key) ->
		keyCodeToName[keyNameToCode[key]] = key

	###
	class: Controller
	Recieves input from keyboard and provides info on
	what keys are currently pressed
	###
	class Controller extends GameObject
		@unique()
		###
		Method: contructor
		Initializes listeners for keydown and keyup events
		Creates dictionary to convert key names to keyCodes
		###
		constructor: ->
			@currentlyPressedKeys = {}
			@listeners = []
			document.addEventListener 'keydown', (event) => @keyDown event
			document.addEventListener 'keyup', (event) => @keyUp event

		#register key as down
		keyDown: (event) ->
			#Disable arrow key scrolling
			switch event.keyCode
				when 32, 37, 38, 39, 40
					event.preventDefault()
			@currentlyPressedKeys[event.keyCode] = yes
			@listeners.forEach (listener) =>
				listener.onButtonDown keyCodeToName[event.keyCode]

		#register key as up (not pressed)
		keyUp: (event) ->
			@currentlyPressedKeys[event.keyCode] = no
			@listeners.forEach (listener) =>
				listener.onButtonUp keyCodeToName[event.keyCode]

		#return if key with name keyName is currently pressed
		isButtonDown: (keyName) ->
			@currentlyPressedKeys[keyNameToCode[keyName]]

		registerListener: (obj) ->
			@listeners.push obj
