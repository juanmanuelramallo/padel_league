class PlayerMailer < ApplicationMailer
  default from: "jugadores@pl.1ma.dev"

  def invite
    @invitee = params[:invitee]
    @inviter = params[:inviter]

    mail(to: @invitee.email, subject: "Invitación a Padel League")
  end

  def reset_password_instructions
    @player = params[:player]

    mail(to: @player.email, subject: "Instrucciones para restablecer tu contraseña")
  end
end
