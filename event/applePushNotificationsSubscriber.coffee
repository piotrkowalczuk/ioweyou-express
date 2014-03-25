emiter = require '../lib/eventEmiter'
clientTable = require '../models/userClient'
apn = require('../lib/apn').apn

module.exports = () ->
  emiter.on 'entryCreation', pushNotificationHandler
  emiter.on 'entryAcceptance', pushNotificationHandler
  emiter.on 'entryRejection', pushNotificationHandler
  emiter.on 'entryModification', pushNotificationHandler

pushNotificationHandler = (data) ->
  clientTable.getByUserId data.userId, (error, client)->
    if client
      apn.createMessage()
        .device(client.token)
        .alert(data.subject)
        .set('entryId', data.entryId)
        .send()