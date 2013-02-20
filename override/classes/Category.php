<?php
class Category extends CategoryCore
{
	public function getProducts($id_lang, $p, $n, $orderBy = NULL, $orderWay = NULL, $getTotal = false, $active = true, $random = false, $randomNumberProducts = 1, $checkAccess = true)
	{
		global $cookie;
		if (!$checkAccess OR !$this->checkAccess($cookie->id_customer))
			return false;

		if ($p < 1) $p = 1;

		if (empty($orderBy))
			$orderBy = 'position';
		else
			/* Fix for all modules which are now using lowercase values for 'orderBy' parameter */
			$orderBy = strtolower($orderBy);

		if (empty($orderWay))
			$orderWay = 'ASC';
		if ($orderBy == 'id_product' OR	$orderBy == 'date_add')
			$orderByPrefix = 'p';
		elseif ($orderBy == 'name')
			$orderByPrefix = 'pl';
		elseif ($orderBy == 'manufacturer')
		{
			$orderByPrefix = 'm';
			$orderBy = 'name';
		}
		elseif ($orderBy == 'position')
			$orderByPrefix = 'cp';

		if ($orderBy == 'price')
			$orderBy = 'orderprice';

		if (!Validate::isBool($active) OR !Validate::isOrderBy($orderBy) OR !Validate::isOrderWay($orderWay))
			die (Tools::displayError());

		$id_supplier = (int)(Tools::getValue('id_supplier'));

		/* Return only the number of products */
		if ($getTotal)
		{
			$result = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow('
			SELECT COUNT(cp.`id_product`) AS total
			FROM `'._DB_PREFIX_.'product` p
			LEFT JOIN `'._DB_PREFIX_.'category_product` cp ON p.`id_product` = cp.`id_product`
			WHERE cp.`id_category` = '.(int)($this->id).($active ? ' AND p.`active` = 1' : '').'
			'.($id_supplier ? 'AND p.id_supplier = '.(int)($id_supplier) : ''));
			return isset($result) ? $result['total'] : 0;
		}


	$sql = '
	SELECT p.*, pa.`id_product_attribute`, pl.`description`, pl.`description_short`, pl.`available_now`, pl.`available_later`, pl.`link_rewrite`, pl.`meta_description`, pl.`meta_keywords`, pl.`meta_title`, pl.`name`, i.`id_image`, il.`legend`, m.`name` AS manufacturer_name, tl.`name` AS tax_name, t.`rate`, cl.`name` AS category_default, DATEDIFF(p.`date_add`, DATE_SUB(NOW(), INTERVAL '.(Validate::isUnsignedInt(Configuration::get('PS_NB_DAYS_NEW_PRODUCT')) ? Configuration::get('PS_NB_DAYS_NEW_PRODUCT') : 20).' DAY)) > 0 AS new,
		(p.`price` * IF(t.`rate`,((100 + (t.`rate`))/100),1)) AS orderprice
	FROM `'._DB_PREFIX_.'category_product` cp
	LEFT JOIN `'._DB_PREFIX_.'product` p ON p.`id_product` = cp.`id_product`
	LEFT JOIN `'._DB_PREFIX_.'product_attribute` pa ON (p.`id_product` = pa.`id_product` AND default_on = 1)
	LEFT JOIN `'._DB_PREFIX_.'category_lang` cl ON (p.`id_category_default` = cl.`id_category` AND cl.`id_lang` = '.(int)($id_lang).')
	LEFT JOIN `'._DB_PREFIX_.'product_lang` pl ON (p.`id_product` = pl.`id_product` AND pl.`id_lang` = '.(int)($id_lang).')
	LEFT JOIN `'._DB_PREFIX_.'image` i ON (i.`id_product` = p.`id_product` AND i.`cover` = 1)
	LEFT JOIN `'._DB_PREFIX_.'image_lang` il ON (i.`id_image` = il.`id_image` AND il.`id_lang` = '.(int)($id_lang).')
	LEFT JOIN `'._DB_PREFIX_.'tax_rule` tr ON (p.`id_tax_rules_group` = tr.`id_tax_rules_group`
	                                           AND tr.`id_country` = '.(int)Country::getDefaultCountryId().'
                                           	   AND tr.`id_state` = 0)
    LEFT JOIN `'._DB_PREFIX_.'tax` t ON (t.`id_tax` = tr.`id_tax`)
	LEFT JOIN `'._DB_PREFIX_.'tax_lang` tl ON (t.`id_tax` = tl.`id_tax` AND tl.`id_lang` = '.(int)($id_lang).')
	LEFT JOIN `'._DB_PREFIX_.'manufacturer` m ON m.`id_manufacturer` = p.`id_manufacturer`
	WHERE cp.`id_category` = '.(int)($this->id).($active ? ' AND p.`active` = 1' : '').'
	'.($id_supplier ? 'AND p.id_supplier = '.(int)$id_supplier : '');


		if ($random === true)
		{
			$sql .= ' ORDER BY RAND()';
			$sql .= ' LIMIT 0, '.(int)($randomNumberProducts);
		}
		else
		{
			$sql .= ' ORDER BY '.(isset($orderByPrefix) ? $orderByPrefix.'.' : '').'`'.pSQL($orderBy).'` '.pSQL($orderWay).'
			LIMIT '.(((int)($p) - 1) * (int)($n)).','.(int)($n);
		}
		$result = Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS($sql);

				for ($i=0;$i<=count($result);$i++){
					$newSql =  '
					SELECT DISTINCT al.name name, agl.name attr
					FROM '._DB_PREFIX_.'product_attribute pa
					LEFT JOIN '._DB_PREFIX_.'product_attribute_combination pac ON pac.id_product_attribute = pa.id_product_attribute
					LEFT JOIN '._DB_PREFIX_.'attribute_lang al ON (al.id_attribute = pac.id_attribute AND al.id_lang = '.intval($id_lang).')
					LEFT JOIN '._DB_PREFIX_.'attribute a ON (a.id_attribute = pac.id_attribute)
					LEFT JOIN '._DB_PREFIX_.'attribute_group_lang agl ON (agl.id_attribute_group = a.id_attribute_group AND agl.id_lang = '.intval($id_lang).')
					WHERE pa.id_product = '.$result[$i]['id_product'].' AND pa.quantity >= 1';

					$attr = Db::getInstance()->ExecuteS($newSql);
					if($attr){
						foreach($attr as $addResult){
							$result[$i]['attribute'][$addResult['attr']][]= $addResult['name'];
						}
					}
				}

		if ($orderBy == 'orderprice')
			Tools::orderbyPrice($result, $orderWay);

		if (!$result)
			return false;

		/* Modify SQL result */
		return Product::getProductsProperties($id_lang, $result);
	}
}



?>