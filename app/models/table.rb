class Table < ApplicationRecord
  singleton_class.send :alias_method, :ensure_amount_create, :create
  singleton_class.send :private, :ensure_amount_create

  def self.create
    raise 'Table.create is disabled, use Table.ensure_amount instead'
  end

  def self.ensure_amount(n)
    if Table.count < n
      (n - Table.count).times do
        ensure_amount_create
      end
    end
  end
end
