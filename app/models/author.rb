# Pair commits provide name and email but no username.
# Regular commits provide all three.
# Comment webhooks only include a username, no email or name.

class Author < ActiveRecord::Base
  validate :has_at_least_one_property

  def self.create_or_update_from_payload(payload)
    CreateOrUpdateFromPayload.call(payload)
  end

  # If the author was created from a comment,
  # it will only have a username.
  def name_or_username
    name || username
  end

  private

  def has_at_least_one_property
    return if name? || email? || username?
    errors.add(:base, "Must have name or email or username.")
  end
end
