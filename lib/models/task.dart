class Task {
  int _id;
  String _name;
  String _description;
  // bool isDone = false;
  String _date;

  Task(this._name, this._description, this._date);
  Task.withId(this._id, this._name, this._description, this._date);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get date => _date;

  // void toggleDone() {
  //   isDone = !isDone;
  // }

  // Map<String, dynamic> toMap() {
  //   var map = Map<String, dynamic>();
  //   if (id != null) {
  //     map['id'] = id;
  //   }
  //   map['title'] = name;
  //   map['date'] = date;

  //   return map;
  // }

  // Task.fromMapObject(Map<String, dynamic> map) {
  //   this.id = map['id'];
  //   this.name = map['title'];
  //   this.date = map['date'];
  // }


  set name(String newName) {
		if (newName.length <= 255) {
			this._name = newName;
		}
	}
	set description(String newDescription) {
		if (newDescription.length <= 255) {
			this._description = newDescription;
		}
	}

	set date(String newDate) {
		this._date = newDate;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['name'] = _name;
		map['description'] = _description;
		map['date'] = _date;

		return map;
	}

	// Extract a Note object from a Map object
	Task.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._name = map['name'];
		this._description = map['description'];
		this._date = map['date'];
	}
}
