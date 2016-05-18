require 'passbook'

Passbook.configure do |passbook|

  # Path to your wwdc cert file
  passbook.wwdc_cert = Rails.root.join('vendor/Certificate/WWDR.pem') # "#{Rails.root}/vendor/Certificate/WWDR.pem"

  # Path to your cert.p12 file
  passbook.p12_certificate = Rails.root.join('vendor/Certificate/Certificates.p12')  # "#{Rails.root}/vendor/Certificate/Certificates.p12"

  # passbook.p12_key = Rails.root.join('vendor/Certificate/passcertificate.pem')

  # Password for your certificate
  passbook.p12_password = ''
end
