-- ==============================================================================
-- ROLLBACK SCRIPT: 20261023100000_hsk6_reconciled_36_words_seed_rollback.sql
-- Hoàn tác nạp 36 từ điều hòa HSK 6
-- ==============================================================================

BEGIN;

DELETE FROM public.vocabularies
WHERE hsk_level = 'HSK 6'
  AND source = 'cti_official_2025'
  AND notes LIKE '%Reconciled batch%'
  AND hanzi IN ('摆放', '尺寸', '冲', '传真', '打卡', '待', '地方', '定位', '副', '该', '改造', '工序', '划', '汇款', '货车', '胶带', '结', '结果', '进度', '开关', '可怜', '落', '录用', '马虎', '清扫', '扇', '升', '所', '通风', '原材料', '炸', '支', '中', '转', '卷', '吐');

COMMIT;
