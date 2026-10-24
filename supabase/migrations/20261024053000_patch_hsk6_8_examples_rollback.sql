-- Rollback for 20261024053000_patch_hsk6_8_examples.sql
BEGIN;

UPDATE public.vocabularies v
SET 
  example_hanzi = l.old_value
FROM public.data_audit_logs l
WHERE v.id = l.record_id
  AND l.migration_tag = '20261024053000_patch_hsk6_8_examples'
  AND l.field_name = 'example_hanzi';

UPDATE public.vocabulary_examples ve
SET 
  chinese = v.example_hanzi
FROM public.vocabularies v
WHERE ve.vocabulary_id = v.id
  AND v.id IN (
    '4365f148-b1c2-4a97-8889-df0549d490ab',
    'ebd82653-b30e-4e50-990e-da859304d5d7',
    'e11826fc-a697-45e9-bd7f-c9df7e49bbe9',
    '386836b6-61d0-4a5f-9248-6ace63a22d06',
    '1a86e414-4daf-4a78-9ed0-9c6a99cf7256',
    '02e4707a-ff73-4d07-92dd-f04e7dacb5a4',
    'babc0bf1-7b03-45e3-9aaa-9974476a56d9',
    '3d43eecb-e61d-4cac-b1a8-4a11ebd0d933'
  )
  AND ve.order_index = 1;

DELETE FROM public.data_audit_logs
WHERE migration_tag = '20261024053000_patch_hsk6_8_examples';

COMMIT;
