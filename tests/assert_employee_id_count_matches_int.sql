-- Silver employee_id count should match int_employees_merged
with counts as (
    select
        (select count(employee_id) from {{ ref('employees') }}) as silver_count,
        (select count(employee_id) from {{ ref('int_employees_merged') }}) as int_count
)
select *
from counts
where silver_count != int_count
