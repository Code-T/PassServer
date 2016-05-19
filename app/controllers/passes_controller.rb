require 'sign_pass'

class PassesController < ApplicationController
  def new
    @pass = Pass.new
  end

  def show
    @pass = Pass.find(params[:id])
    @salon = @pass.salon
    @location = @salon.location

    passes_folder_path = "#{Rails.root}/public/assets/passes/"
    template_folder_path = passes_folder_path + "/template"
    target_folder_path = passes_folder_path + "/#{@pass.serial_number}"


    if (File.exists?(target_folder_path))
      puts "[ ok ] Deleting existing pass data."
      FileUtils.remove_dir(target_folder_path)
    end

    puts "[ ok ] Creating pass data from template."
    FileUtils.cp_r template_folder_path + "/.", target_folder_path
    json_file_path = target_folder_path + "/pass.json"
    pass_json = JSON.parse(File.read(json_file_path))
    # pass_json["passTypeIdentifier"] = settings.pass_type_identifier
    # pass_json["teamIdentifier"] = settings.team_identifier
    pass_json["serialNumber"] = @pass.serial_number
    pass_json["authenticationToken"] = @pass.authentication_token
    # pass_json["webServiceURL"] = "http://#{settings.hostname}:#{settings.port}/"
    pass_json["barcode"]["message"] = @pass.barcode_message

    pass_json["relevantDate"] = @salon.time

    pass_json["eventTicket"]["primaryFields"][0]["value"] = @salon.topic

    pass_json["eventTicket"]["auxiliaryFields"][0]["value"] = @salon.detail_location
    pass_json["eventTicket"]["auxiliaryFields"][1]["value"] = @salon.time

    pass_json["eventTicket"]["secondaryFields"][0]["label"] = @pass.user_type
    pass_json["eventTicket"]["secondaryFields"][0]["value"] = @pass.user_name

    pass_json["eventTicket"]["backFields"][0]["value"] = @salon.detail_info
    pass_json["eventTicket"]["backFields"][1]["value"] = @salon.guests
    pass_json["eventTicket"]["backFields"][2]["value"] = @salon.help
    pass_json["eventTicket"]["backFields"][3]["value"] = @salon.about

    pass_json["eventTicket"]["headerFields"][0]["value"] = @location.name

    File.open(json_file_path, "w") do |f|
      f.write JSON.pretty_generate(pass_json)
    end

    pass_folder_path = target_folder_path
    pass_signing_certificate_path = "#{Rails.root}/vendor/Certificate/Certificates.p12"
    wwdr_certificate_path = "#{Rails.root}/vendor/Certificate/WWDR.pem"
    pass_output_path = passes_folder_path + "/#{@pass.serial_number}.pkpass"

    # Remove the old pass if it exists
    if File.exists?(pass_output_path)
      File.delete(pass_output_path)
    end

    # Generate and sign the new pass
    pass_signer = SignPass.new(pass_folder_path, pass_signing_certificate_path, '', wwdr_certificate_path, pass_output_path)
    pass_signer.sign_pass!

    send_file(pass_output_path,
              type: "application/vnd.apple.pkpass")
  end

  def create
    @salon = Salon.find(params[:salon_id])
    @pass = @salon.passes.create(pass_params)
    @pass.serial_number = new_serial_number
    @pass.authentication_token = new_authentication_token
    @pass.barcode_message = new_barcode_message

    if @pass.save
      redirect_to salon_path(@salon)
    else
      render 'new'
    end
  end

  def download
    render @pass = Pass.where(["serial_number = :p", { p: params[:serial_number] }]).first
  end

  def destroy
    @salon = Salon.find(params[:salon_id])
    @pass = @salon.passes.find(params[:id])
    @pass.destroy
    redirect_to salon_path(@salon)
  end

  private
    def pass_params
      params.require(:pass).permit(:user_name, :user_phone_number, :user_type)
    end

    def new_serial_number
      SecureRandom.hex
    end

    def new_authentication_token
      SecureRandom.hex
    end

    def new_barcode_message
      SecureRandom.hex
    end

end
