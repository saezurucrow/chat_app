document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create {channel:"RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#messages').append data['message']
      
    speak: (message)->
      @perform 'speak', message: message

    $(document).on 'keydown', '[data-behavior~=room_speaker]', (event) ->
      if event.keyCode is 13
        App.room.speak event.target.value
        event.target.value = ''
        event.preventDefault()

    #received: (data) ->
     # $('#messages').append data['message']
