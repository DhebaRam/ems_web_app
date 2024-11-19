class Employee {
  final int? id;
  final String name;
  final String role;
  final String startDate;
  final String? endDate;

  Employee({
    this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  // Convert Employee to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  // Create Employee from Map
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      startDate: map['start_date'],
      endDate: map['end_date'],
    );
  }
}
