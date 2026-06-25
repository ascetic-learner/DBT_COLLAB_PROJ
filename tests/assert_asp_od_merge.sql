-- Aspen silver rows should match stg_employees_asp first names
select
    e.employee_id,
    e.first_name,
    e.ssn
from {{ ref('employees') }} e
where e.source = 'asp'
  and e.employee_id in (
      select employee_id from {{ ref('stg_employees_asp') }}
  )
  and (
      e.first_name is null
      or e.first_name != (
          select s.first_name
          from {{ ref('stg_employees_asp') }} s
          where s.employee_id = e.employee_id
            and s.source = e.source
      )
  )
