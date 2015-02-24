class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members ||= Member.all
    @members = @members.order(:name).to_a
    @left = @members.any? { |m| m.left_on.present? }
    @show_phone = @members.any? { |m| m.phone.present? }
    @show_guardian_2 = @members.any? { |m| m.guardian_2.present? || m.guardian_2_email.present? || m.guardian_2_mobile.present? }
    @emails = @members.map(&:emails).flatten
    render :index
  end

  def active
    @members = Member.active
    index
  end

  def left
    @members = Member.left
    index
  end

  def show
  end

  def faktura
    last_annual_meeting = AnnualMeeting.order(:start_at).last
    unless last_annual_meeting
      redirect_to new_annual_meeting_path
      return
    end
    unless last_annual_meeting.fee
      redirect_to edit_annual_meeting_path(last_annual_meeting)
      return
    end
    member = Member.find(params[:id])
    last_invoice = member.invoices.last
    if last_invoice.nil? || last_invoice.created_at < 3.months.ago
      invoice = Invoice.create! member_id: member.id, amount: last_annual_meeting.fee
      flash.notice = "Opprettet og sender ny faktura for #{member.name}"
    else
      invoice = last_invoice
    end
    pdf = invoice.pdf
    send_data pdf, filename: "#{invoice.title.gsub(/ |\/|\\/, '_')}.pdf",
        type: 'application/pdf'
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to edit_member_path(@member), notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  def update
    if @member.update(member_params)
      redirect_to edit_member_path(@member), notice: 'Oppdatert medlemsinformasjon lagret.'
    else
      render :edit
    end
  end

  # def destroy
  #   @member.destroy
  #   redirect_to members_url, notice: 'Member was successfully destroyed.'
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:name, :address, :birthdate, :left_on,
        :postal_code, :post_office, :guardian_1, :guardian_1_mobile,
        :guardian_2, :guardian_2_mobile, :joined_on, :female, :email,
        :guardian_1_email, :guardian_2_email, :mobile, :phone)
  end
end
