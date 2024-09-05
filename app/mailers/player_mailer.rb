class PlayerMailer < ApplicationMailer
  default from: "jugadores@pl.1ma.dev <Jugadores Padel League>"

  def invite
    @invitee = params[:invitee]
    @inviter = params[:inviter]

    mail(to: @invitee.email, subject: "Invitación a Padel League")
  end
end
