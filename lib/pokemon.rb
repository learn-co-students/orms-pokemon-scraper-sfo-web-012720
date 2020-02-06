class Pokemon

    attr_accessor :id, :name, :type, :db
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def update
        sql = "UPDATE pokemon SET name = ?, type = ?, db = ? WHERE id = ?"
        DB[:conn].execute(sql, @name, @type, @db, @id)
      end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?);
        SQL
        db.execute(sql, name, type)        
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon 
            WHERE id = ?;
        SQL
        # returns whole thing, needs flatten to make one array
        search = db.execute(sql, id).flatten
        # need to write out the keys
        Pokemon.new(id: search[0],name: search[1],type: search[2],db: db)
    end
end
