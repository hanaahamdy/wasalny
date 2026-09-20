enum EmployeeType { delivery, buyer, packer, alia }

extension EmployeeTypeApiValue on EmployeeType {
  String get apiValue => switch (this) {
    EmployeeType.delivery => 'delivery',
    EmployeeType.buyer => 'sales',
    EmployeeType.packer => 'packing',
    EmployeeType.alia => 'supervisor',
  };
}

enum EmployeeCycle { cycleOne, cycleTwo }
