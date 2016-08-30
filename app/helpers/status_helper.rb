# Methods relating to inferring patient status
module StatusHelper
  STATUSES = {
    no_contact: 'No Contact Made',
    needs_appt: 'Needs Appointment',
    fundraising: 'Fundraising',
    pledge_sent: 'Pledge Sent',
    pledge_paid: 'Pledge Paid',
    resolved: 'Resolved Without DCAF'
  }.freeze

  def status
    return STATUSES[:resolved] if pregnancy.resolved_without_dcaf?
    return STATUSES[:pledge_sent] if pregnancy.pledge_sent?
    return STATUSES[:fundraising] if appointment_date
    return STATUSES[:needs_appt] if contact_made?
    STATUSES[:no_contact]
  end

  private

  def contact_made?
    calls.each do |call|
      return true if call.status == 'Reached patient'
    end
    false
  end
end
