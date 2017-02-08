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

  def save
    instance_variables = self.instance_variables - [:@id]
    values = instance_variables.map{ |name| instance_variable_get(name)}
    names = instance_variables.map { |name| name.to_s[1..-1]}.join(', ')
    q_marks = (['?']*instance_variables.length).join(', ')
    if @id.nil?
      #save it
      QuestionsDatabase.instance.execute(<<-SQL, *values)
        INSERT INTO
          #{get_database_name} (#{names})
        VALUES
          (#{q_marks})
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      #update it
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
      SQL
    end
  end

end
