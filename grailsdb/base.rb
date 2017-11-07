require_relative 'db_connection'
require 'active_support/inflector'
require_relative '02_searchable'


module GrailedORM
  class Base
    extend GrailedORM::Searchable
    extend GrailedORM::Associatable


    def self.columns
      @columns ||= DBConnection.execute2(<<-SQL).first.map(&:to_sym)
      SELECT
      *
      FROM
      #{self.table_name}
      SQL
    end

    def self.finalize!
      columns.each do |column|
        define_method("#{column}=") { |val| attributes[column] = val }

        define_method(column) { attributes[column]}
      end
    end

    def self.table_name=(table_name)
      @table_name = table_name.tableize
    end

    def self.table_name
      @table_name ||= self.to_s.downcase.pluralize
    end

    def self.all
      results = DBConnection.execute(<<-SQL)
      SELECT
      *
      FROM
      #{self.table_name}
      SQL

      parse_all(results)
    end

    def self.parse_all(results)
      results.map do |optionshash|
        self.new(optionshash)
      end
    end

    def self.find(id)
      result = DBConnection.execute(<<-SQL, id)
      SELECT
      *
      FROM
      #{self.table_name}
      WHERE
      id = ?
      LIMIT 1
      SQL
      parse_all(result).first
    end

    def initialize(params = {})
      params.each do |attri, val|
        if !self.class.columns.include?(attri.to_sym)
          raise "unknown attribute '#{attri}'"
        end
        self.send("#{attri}=", val)
      end
    end

    def attributes
      @attributes ||= {}
    end

    def attribute_values
      self.class.columns.map { |col| self.send(col) }
    end

    def insert
      columns = self.class.columns.drop(1)
      col_names = columns.map(&:to_s).join(", ")
      questionmarks = (["?"] * columns.length).join(", ")

      DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
      #{self.class.table_name} (#{col_names})
      VALUES
      (#{questionmarks})
      SQL
      self.id = DBConnection.last_insert_row_id
    end

    def update
      columns = self.class.columns.drop(1)
      col_names = columns.map { |name| "#{name.to_s} = ?" }.join(", ")


      DBConnection.execute(<<-SQL, *attribute_values.drop(1), self.id)
      UPDATE
      #{self.class.table_name}
      SET
      #{col_names}
      WHERE
      id = ?
      SQL
    end

    def save
      if self.id.nil?
        insert
      else
        update
      end
    end
  end
end
