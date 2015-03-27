module Teamwork
  class Sync
    def initialize client
      @client = client
    end

    def employees!
      warn "Syncing Employees from Teamwork authors ... "
      @client.authors.each { |author| sync_employee! author }
      warn "#{Employee.count} Employees"
      Employee.all
    end

    def journals!
      warn "Syncing Journals from Teamwork ... "
      @client.journals.each { |journal| sync_journal! journal }
      warn "#{Journal.count} journals"
      Journal.all
    end

private

    def sync_employee! author
      Employee.where(teamwork_id: author["id"]).first_or_create! do |e|
        e.email      = author["email-address"]
        e.first_name = author["first-name"]
        e.last_name  = author["last-name"]
      end
    rescue => e
      name = "#{author['first-name']} #{author['last-name']}".strip
      # FIXME: use logger, enable logger during seed load
      warn "Failed to sync '#{name}' - #{e}"
    end

    def author_map
      @_author_map ||= Employee.find_each.map { |e| [e.teamwork_id, e.id] }.to_h
    end

    def sync_journal! journal
      Journal.where(teamwork_id: journal["id"]).first_or_create! do |r|
        r.author_id = author_map[journal["author-id"]]
        r.title     = journal["title"]
        r.body      = journal["body"]
      end
    rescue => e
      warn "Failed to sync '#{journal['title']}' - #{e}"
    end
  end
end
