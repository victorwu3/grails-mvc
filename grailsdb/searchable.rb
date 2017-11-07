require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    cols = params.keys
    vals = params.values
    where = cols.map { |name| "#{name.to_s} = ?"}.join(" AND ")
    result = DBConnection.execute(<<-SQL, vals)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{where}
    SQL
    self.parse_all(result)
  end
end

class SQLObject
  extend Searchable
end
