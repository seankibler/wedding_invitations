class FreeAccountLookup
  EMAIL_LIST_FILE = File.join(Rails.root, 'config', 'free_account_emails.yml')

  def initialize(email)
    @email = email
    @free_emails = load_emails
  end

  def pass?
    @free_emails.include? @email
  end

  def load_emails
    if File.exist?(EMAIL_LIST_FILE) 
      YAML.load(File.open(EMAIL_LIST_FILE))
    else
      []
    end
  end
end
