# frozen_string_literal: true

class Admin::DeviseMailer < Admin::ApplicationMailer
  default from: "from@example.com"
  layout "mailer"

  def confirmation_instructions(resource)
    subject = "会員登録のご案内"
    template_path = "admin/mailer/devise"
    template_name = "confirmation_instructions"
    @token = resource&.confirmation_token
    @email = resource&.unconfirmed_email

    mail(
      to: @email,
      subject: subject,
      template_path: template_path,
      template_name: template_name
    )
  end
end
