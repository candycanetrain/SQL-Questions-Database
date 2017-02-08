class ModelBase

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id, )
      SELECT
        *
      FROM
        #{get_database_name}
      WHERE
        id = ?
    SQL

    data.empty? ? nil : self.new(data.first)
  end

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{get_database_name}
    SQL

    data.map {|item| self.new(item)}
  end

end
