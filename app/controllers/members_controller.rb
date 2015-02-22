class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.all.to_a
    @left = true
    @show_phone = @members.any? { |m| !m.phone.blank? }
    @show_guardian_2 = @members.any? { |m| !m.guardian_1.blank? || !m.guardian_1_email.blank? || !m.guardian_1_mobile.blank? }
  end

  def active
    @members = Member.active.to_a
    @layout_emails = @members.map{|m|[m.email, m.guardian_1_email, m.guardian_2_email]}.flatten.compact
    render :index
  end

  def left
    @members = Member.left.to_a
    @left = true
    render :index
  end

  def show
  end

  def faktura
    @member = Member.find(params[:id])
    invoice = Invoice.new(@member)
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
