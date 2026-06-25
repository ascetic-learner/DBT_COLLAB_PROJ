-- Axi employees merged with odata should have matching first names
select
    e.employee_id,
    e.first_name,
    e.ssn
from {{ ref('employees') }} e
where e.source = 'axi'
  and e.employee_id in (
      select employeeid from {{ source('axi_odata', 'vw_employees') }}
  )
  and (
      e.first_name is null
      or e.first_name != (
          select firstname
          from {{ source('axi_odata', 'vw_employees') }} od
          where od.employeeid = e.employee_id
            and od.source = e.source
      )
  )
