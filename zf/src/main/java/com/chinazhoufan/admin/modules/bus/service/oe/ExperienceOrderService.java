package com.chinazhoufan.admin.modules.bus.service.oe;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.modules.bus.entity.bs.BreakdownStandard;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrderDueTemp;
import com.chinazhoufan.admin.modules.bus.entity.ol.ExpressBroken;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.ExpressBrokenService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackItemService;

import com.google.common.collect.Maps;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.dao.oe.ExperienceOrderDao;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.service.RefundService;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.bus.service.op.OrderPayService;
import com.chinazhoufan.admin.modules.bus.service.pj.ProduceJudgeService;
import com.chinazhoufan.admin.modules.crm.entity.mb.Beans;
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansDetail;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.mb.BeansDetailService;
import com.chinazhoufan.admin.modules.crm.service.mb.BeansService;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.mobile.wechat.service.pay.config.OrderType;

/**
 * 体验单Service
 *
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class ExperienceOrderService extends CrudService<ExperienceOrderDao, ExperienceOrder> {

    @Autowired
    private ExperienceProduceService experienceProduceService;
    @Autowired
    private ExperiencePackItemService experiencePackItemService;
    @Autowired
    private BuyOrderService buyOrderService;
    @Autowired
    private OrderPayService orderPayService;
    @Autowired
    private ExpressBrokenService expressBrokenService;
    @Autowired
    private SendOrderService sendOrderService;
    @Autowired
    private ReturnOrderService returnOrderService;
    @Autowired
    private ProduceJudgeService produceJudgeService;
    @Autowired
    private ServiceApplyService serviceApplyService;
    @Autowired
    private ProduceService produceService;
    @Autowired
    private BeansDetailService beansDetailService;
    @Autowired
    private WhProduceService whProduceService;
    @Autowired
    private MemberNotifyService memberNotifyService;

    @Autowired
    private ReturnProductService returnProductService;

    public ExperienceOrder get(String id) {
        return super.get(id);
    }

    /**
     * 根据订单ID获取体验订单信息及体验产品信息
     *
     * @param id 体验订单ID
     * @return
     */
    public ExperienceOrder getDetail(String id) {
        ExperienceOrder experienceOrder = new ExperienceOrder(id);
        return dao.getDetail(experienceOrder);
    }

    ;

    public List<ExperienceOrder> findList(ExperienceOrder experienceOrder) {
        return super.findList(experienceOrder);
    }

    public Page<ExperienceOrder> findPage(Page<ExperienceOrder> page, ExperienceOrder experienceOrder) {
        return super.findPage(page, experienceOrder);
    }

    @Transactional(readOnly = false)
    public void save(ExperienceOrder experienceOrder) {
        //更新发货单的用户信息
        SendOrder sendOrder = new SendOrder();
        sendOrder.setReceiveName(experienceOrder.getReceiveName());
        sendOrder.setReceiveTel(experienceOrder.getReceiveTel());
        sendOrder.setReceiveAreaStr(experienceOrder.getReceiveAreaStr());
        sendOrder.setReceiveAreaDetail(experienceOrder.getReceiveAreaDetail());
        sendOrder.setMemberRemarks(experienceOrder.getMemberRemarks());
        sendOrder.setOrderId(experienceOrder.getId());
        sendOrderService.updateByOrder(sendOrder);
        super.save(experienceOrder);
    }

    @Transactional(readOnly = false)
    public void delete(ExperienceOrder experienceOrder) {
        super.delete(experienceOrder);
    }

    /**
     * 后台工作人员执行关闭订单的操作
     *
     * @param experienceOrder
     */
    @Transactional(readOnly = false)
    public void closeExperienceOrder(ExperienceOrder experienceOrder) {
        // 只有系统订单状态为“待支付”、且支付状态为“待支付”或“待付定金”的体验单才可以关闭
        if (!ExperienceOrder.STATUSSYSTEM_TOPAY.equals(experienceOrder.getStatusSystem())
                ||
                (!ExperienceOrder.STATUSPAY_TOPAY_TOTAL.equals(experienceOrder.getStatusPay())
                        && !ExperienceOrder.STATUSPAY_TOPAY_APPOINT.equals(experienceOrder.getStatusPay()))) {
            throw new ServiceException("警告：当前体验单的系统订单状态不是“待支付”、或支付状态不是待付全款或待付定金状态，不允许执行关闭操作");
        }

        experienceOrder.setStatusMember(ExperienceOrder.STATUSMEMBER_CLOSE);
        experienceOrder.setStatusSystem(ExperienceOrder.STATUSSYSTEM_CLOSE);
        experienceOrder.setCloseType(ExperienceOrder.CLOSETYPE_STAFF);
        experienceOrder.setCloseTime(new Date());
        super.save(experienceOrder);
    }

//	/**
//	 * 根据产品ID和订单类型，将预约体验单里面的  预约到货状态  由  待采购 -> 已到货
//	 * @param experienceOrder
//	 */
//	public void updateAppointStockStatusByProduce(ExperienceOrder experienceOrder) {
//		dao.updateAppointStockStatusByProduce(experienceOrder);
//	};


    /**
     * 统计体验单里面当天的成交量，包括预约体验
     *
     * @param experienceOrder
     * @return
     */
    public Integer statExperienceOrderDayTradingVolume(ExperienceOrder experienceOrder) {
        return dao.statExperienceOrderDayTradingVolume(experienceOrder);
    }


    /**
     * 体验单自动结算（zf体验单相关退货单退回完成<>时调用，zf-index购买所有体验产品时调用<zf-index的ExperienceOrderSettleService.settleExperienceOrder方法>）
     * 步骤：
     * 1.验证数据
     * 2.计算订单结算退款金额
     * 3.执行退款
     * 4.更新体验单
     * 5.发送消息
     *
     * @param experienceOrder 体验单
     * @throws ServiceException
     * @throws IOException
     */
    @Transactional(readOnly = false)
    public void settleExperienceOrderAuto(ExperienceOrder experienceOrder) throws ServiceException, IOException {
        logger.info("------体验单自动结算settleExperienceOrderAuto------");
        logger.debug("settle experienceOrder auto info:[experienceOrderId=" + experienceOrder.getId() + "]");
        String isLightBroken = experienceOrder.getIsLightBroken();
        String isAutoBuy = experienceOrder.getIsAutoBuy();
        Boolean isFullBuy = true;
        // 根据体验单ID，查询对应体验单、体验产品
        experienceOrder = this.getDetail(experienceOrder.getId());
        String orderType = ExperienceOrder.TYPE_EXPERIENCE.equals(experienceOrder.getType()) ? OrderType.EXPERIENCE.getType() : OrderType.APPOINTEXPERIENCE.getType();
        String messageCode = null;
        int outDays = 0;

        /**
         * 1.验证数据
         */
        // 只有“体验中”或“退货中”的体验单可以进行结算操作（所有东西直接转购买的体验单为“体验中”状态）
        if (!ExperienceOrder.STATUSSYSTEM_EXPERIENCING.equals(experienceOrder.getStatusSystem())
                && !ExperienceOrder.STATUSSYSTEM_RETURNING.equals(experienceOrder.getStatusSystem())
                && !ExperienceOrder.STATUSSYSTEM_DECIDING.equals(experienceOrder.getStatusSystem())) {
            logger.debug("settle experienceOrder exception:体验单不是“体验中”或“退货中”或“决策中”状态，不能进行自动结算");
            throw new ServiceException("体验单不是“体验中”或“退货中”或“决策中”状态，不能进行自动结算");
        }

        // 判断体验单下体验产品是否都进入"待结算"状态
        for (ExperienceProduce experienceProduce : experienceOrder.getEpList()) {
            if (!ExperienceProduce.STATUS_TOSETTLEMENT.equals(experienceProduce.getStatus())) {
                logger.debug("settle experienceOrder exception:体验单下有不是“待结算”状态的体验产品，不能进行自动结算");
                throw new ServiceException("体验单下有不是“待结算”状态的体验产品，不能进行自动结算");
            }
        }

        // 判断标记为全额退款的体验单（fullRefundFlag=1），是否其下所有体验产品消费决策都是退货
        if (ExperienceOrder.TRUE_FLAG.equals(experienceOrder.getFullRefundFlag())) {
            for (ExperienceProduce experienceProduce : experienceOrder.getEpList()) {
                if (!ExperienceProduce.DECISIONTYPE_RETURN.equals(experienceProduce.getDecisionType())) {
                    logger.debug("settle experienceOrder exception:标记为全额退款的体验单下有不是消费决策为“退货”的体验产品，自动结算失败");
                    throw new ServiceException("标记为全额退款的体验单下有不是消费决策为“退货”的体验产品，自动结算失败");
                }
            }
        }

        /**
         * 2.计算订单结算退款金额
         */
        BigDecimal returnMoney = new BigDecimal("0");                        // 实际应退金额（退回给用户）
        if (ExperienceOrder.TRUE_FLAG.equals(experienceOrder.getFullRefundFlag())) {
            // 标记为全额退款的体验单，结算退款金额 = 体验单已支付金额
            returnMoney = experienceOrder.getMoneyPaid();
        } else {
            // 未标记为全额退款的体验单，退款金额 = 结算原始应退金额 - （结算扣减金额 - 魅力豆可抵金额） - 滞纳金 - 回程快递费用(有免责时为0) + 去程快递费用(无免责时为0)
            BigDecimal srcReturnMoney = new BigDecimal("0");                // 结算原始应退金额（购买则为体验押金和购买价的差价，其他则为体验押金）
            BigDecimal settlementDecMoney = new BigDecimal("0");            // 结算扣减金额（退货单产生质检扣减金额；有服务申请单，则不扣<设置结算扣减金额为0>；没有服务申请单，则设置结算扣减金额等于质检扣减金额）
            BigDecimal settlementDecableBeansMoney = new BigDecimal("0");    // 魅力豆可抵金额（结算扣减金额中可用魅力豆抵扣的部分）
            BigDecimal settlementDecBeansMoney = new BigDecimal("0");        // 魅力豆抵扣金额（结算扣减金额中实际使用魅力豆抵扣的部分）
            Integer settlementDecBeansNum = 0;                                // 魅力豆抵扣数量
            BigDecimal overdueMoney = new BigDecimal("0");                    // 结算滞纳金（延迟回货滞纳金）
            BigDecimal returnableExpressMoney = new BigDecimal("0");        // 应退回程运费
            BigDecimal goableExpressMoney = new BigDecimal("0");            // 应退去程运费

            BigDecimal buyOrderMoney = new BigDecimal("0");                    // 购买单金额


            BigDecimal moneyExperience = new BigDecimal("0");            //体验费

            //全部转购买的订单退回程运费--原逻辑
            //现逻辑 --- 全部转购买也不退回程运费
//            for (ExperienceProduce experienceProduce : experienceOrder.getEpList()) {
//                if(!ExperienceProduce.DECISIONTYPE_BUY.equals(experienceProduce.getDecisionType())){
//                    isFullBuy=false;
//                }
//            }
//            if(isFullBuy){
//                returnableExpressMoney = experienceOrder.getMoneyBackLgt();
//            }

            // 查询该订单对应的所有可免责的服务申请，用于计算产品的结算扣减金额
            List<ServiceApply> serviceApplyList = serviceApplyService.findReliefList(orderType, experienceOrder.getId());

            // 查询订单对应退货单
            ReturnOrder returnOrder = returnOrderService.getByOrder(orderType, experienceOrder.getId());
            if (returnOrder != null
                    && returnOrder.getExpressPrice() != null
                    && serviceApplyList != null
                    && serviceApplyList.size() != 0) {
                // 订单有可免责的服务申请，则退体验费，回程和去程快递费用
                goableExpressMoney = BigDecimal.ZERO;
                returnableExpressMoney = experienceOrder.getMoneyBackLgt();
                messageCode = Notify.MSG_ORDER_CANCEL_RELIEF;
                moneyExperience = experienceOrder.getMoneyExperience();
            } else if (returnOrder != null
                    && returnOrder.getExpressPrice() != null
                    && (serviceApplyList == null
                    || serviceApplyList.size() == 0)) {
                // 用户如有体验包，则退去程快递费用,退货单有回程快递费用，订单无可免责的服务申请，且用户体验包无免回程运费则不退回程费用
                Map<String, Object> param = new HashMap<>();
                if (experienceOrder.getExperiencePack() != null && experienceOrder.getExperiencePack().getId() != null) {
                    param.put("experiencePackId", experienceOrder.getExperiencePack().getId());
                    param.put("type", ExperiencePack.TYPE_NORMAL);
                    param.put("status", ExperiencePackItem.CAN_USE);
                    param.put("orderTime", experienceOrder.getCreateDate());
                    ExperiencePackItem experiencePackItem = experiencePackItemService.getByMemberAndType(param);
                    if (experiencePackItem != null && experiencePackItem.getExperiencePack() != null) {
                        goableExpressMoney = BigDecimal.ZERO;
                        String expressMoney = experiencePackItem.getExperiencePack().getExpressMoney();
                        if (ExperiencePack.EXPRESS_NO.equals(expressMoney)) {//无免责为0
                            returnableExpressMoney = BigDecimal.ZERO;
                        }
                    }
                }
            }

            /**
             * 非全部购买的体验单（预约取件日期不为空），根据体验开始日期计算体验结束日期。
             * 如果快递预约日期在体验结束日期之后，计算间隔天数，按照系统设定的每天滞纳金数额，计算应收滞纳金总额
             * 如果快递预约日期在体验结束日期之前，不收取滞纳金
             * (如果实际体验日期没有回写，暂时表示客户没有既没有确认收货，系统也没自动更新确认收货，则不收取滞纳金)
             */
            /*if(experienceOrder.getAppointPickDate() != null && experienceOrder.getRealExpDate() != null){
                Date realExpDate = experienceOrder.getRealExpDate();	// 实际体验日期（体验开始日期）
				String experienceDaysStr = ConfigUtils.getConfig("experienceOrderExperienceDays").getConfigValue();	// 体验订单可体验时长（天）
				Integer experienceDays = Integer.valueOf(experienceDaysStr);
				Date realExpEndDate = DateUtils.getDateOffset(realExpDate, 5, experienceDays-1);	// 体验结束日期
				if(DateUtils.compare_date(experienceOrder.getAppointPickDate(), realExpEndDate) == 1){
					BigDecimal overdueDays = new BigDecimal(DateUtils.getDistanceOfTwoDate(realExpEndDate, experienceOrder.getAppointPickDate()));	// 延迟回货天数
					BigDecimal delayMoneyPerDay = new BigDecimal(ConfigUtils.getConfig("experienceOrderDelayMoneyPerDay").getConfigValue());		// 体验订单延迟归还每天收取滞纳金金额
					overdueMoney = delayMoneyPerDay.multiply(overdueDays);
				}
			}*/
            Date realExpDate = experienceOrder.getRealExpDate();    // 实际体验日期（体验开始日期）
            boolean isOutDate = false;
            String experienceDaysStr = ConfigUtils.getConfig("experienceOrderExperienceDays").getConfigValue();    // 体验订单可体验时长（天）
            //Integer experienceDays = Integer.valueOf(experienceDaysStr);
           //取消从配置表里取体验时长，更改为体验包时长
            Integer experienceDays =experienceOrder.getExperienceDays() == null?Integer.valueOf(experienceDaysStr):experienceOrder.getExperienceDays();
            if(realExpDate != null){//实际体验时间为空，即为用户在确认收货前申请退货或者拒收，不收滞纳金
                Date realExpEndDate = DateUtils.getDateOffset(realExpDate, 5, experienceDays - 1);    // 体验结束日期
                if(experienceOrder.getAppointPickDate() == null){
                    logger.debug("settle experienceOrder exception:体验订单预约快递时间为空，自动结算默认为自动转购买结算");

                    //throw new ServiceException("体验订单预约快递时间为空，自动结算失败");
                }else{
                    if (DateUtils.compare_date(experienceOrder.getAppointPickDate(), realExpEndDate) == 1) {//根据订单预约快递时间结算滞纳金
                        isOutDate = true;
                        outDays = (int) DateUtils.getDistanceOfTwoDate(realExpEndDate, experienceOrder.getAppointPickDate());
                    }
                }
            }

            //校验此单回货时是否存在包裹核对
            boolean isCheck = false;
            if (returnOrder != null) {
                ExpressBroken expressBroken = expressBrokenService.findByReturnOrderId(returnOrder.getId());
                //检查此包裹是否存在损坏记录
                if (null != expressBroken) {
                    isCheck = true;
                }
            }
            //校验回货单的货品损坏类型：如果所有货品损坏类型都是换新，则不扣回程运费
            /*boolean isAllBreak = true;
            if(returnOrder == null){
                isAllBreak = false;
            }else{
                List<ReturnProduct> productList = returnProductService.getByReturnOrder(returnOrder.getId());
                for (ReturnProduct re : productList) {
                    if (!ReturnProduct.Dt_3.equals(re.getDamageType())) {
                        isAllBreak = false;
                    }
                }
            }*/
            for (ExperienceProduce experienceProduce : experienceOrder.getEpList()) {
                // 当前订单产品，设置结算扣减金额为质检扣减金额
                if (isCheck && ExperienceOrder.EXPRESS_FAILED.equals(experienceOrder.getStatusLogistical())) {
                    //如果该订单拒收且存在包裹损坏，则不算扣减金额也不扣来回运费
                    experienceProduce.setMoneySettDec(BigDecimal.ZERO);
                    returnableExpressMoney = experienceOrder.getMoneyBackLgt();
                    goableExpressMoney = BigDecimal.ZERO;
                } else if (!isCheck && ExperienceOrder.EXPRESS_FAILED.equals(experienceOrder.getStatusLogistical())) {//如果存在包裹核对记录则不扣用户的质检金额
                    //如果该订单拒收，不存在包裹损坏，则不算扣减金额，扣来回运费（上面已经计算，无需再算）
                    experienceProduce.setMoneySettDec(BigDecimal.ZERO);
                    messageCode = Notify.MSG_ORDER_CANCEL_CLAIM;
                } else if (isCheck && ExperienceOrder.EXPRESS_SIGNED.equals(experienceOrder.getStatusLogistical())) {
                    //如果该订单签收，存在包裹损坏，则不算扣减金额，扣来回运费
                    experienceProduce.setMoneySettDec(BigDecimal.ZERO);
                    messageCode = Notify.MSG_ORDER_CANCEL_CLAIM;
                } else {
                    experienceProduce.setMoneySettDec(experienceProduce.getMoneyCheckDec());
                    for (ServiceApply saTemp : serviceApplyList) {
                        if (experienceProduce.getId().equals(saTemp.getOrderProduceId())) {
                            // 如果该订单产品有可免责的服务申请，则设置结算扣减金额为0
                            experienceProduce.setMoneySettDec(BigDecimal.ZERO);
                            messageCode = Notify.MSG_ORDER_CANCEL_RELIEF;
                        }
                    }
                }

                //如果是自动转购买则退回程运费
                if("true".equals(isAutoBuy)){
                    returnableExpressMoney = experienceOrder.getMoneyBackLgt();
                }
               /* if (isAllBreak) {
                    returnableExpressMoney = returnOrder.getExpressPrice();
                }*/
                switch (experienceProduce.getDecisionType()) {
                    case ExperienceProduce.DECISIONTYPE_RETURN:        // 退
                        // 退货产品结算押金金额累加（体验押金 * 数量）
                        srcReturnMoney = srcReturnMoney.add(experienceProduce.getPriceExperienceDeposit().multiply(new BigDecimal(experienceProduce.getNum() - (experienceProduce.getBuyNum() == null ? 0 : experienceProduce.getBuyNum()))));
                        // 退货产品结算扣减金额累加
                        settlementDecMoney = settlementDecMoney.add(experienceProduce.getMoneySettDec());
                        // 退货产品结算魅力豆可抵金额累加
                        settlementDecableBeansMoney = settlementDecableBeansMoney.add(experienceProduce.getMoneySettDecableBeans() == null ? BigDecimal.ZERO : experienceProduce.getMoneySettDecableBeans());
                        if (isOutDate) {
                            Produce produce = produceService.get(experienceProduce.getProduce().getId());
                            overdueMoney = overdueMoney.add(produce.getPriceSrc().multiply(produce.getScaleExperienceFee())
                                    .divide(new BigDecimal(experienceDays)).multiply(new BigDecimal(outDays)));
                        }
                        // 更新体验产品状态为“体验结束”
                        experienceProduce.setStatus(ExperienceProduce.STATUS_FINISH);
                        experienceProduce.setExperienceOrder(experienceOrder);
                        experienceProduceService.save(experienceProduce);
                        break;
                    case ExperienceProduce.DECISIONTYPE_BUY:        // 买
                        // 购买产品应退金额累加（（体验押金 - 购买价） * 数量）
                    /*if(experienceProduce.getPriceExperienceDeposit().compareTo(experienceProduce.getPriceBuy()) == -1){
                        logger.debug("settle experienceOrder exception:体验订单中有产品的当前购买价格高于其体验押金，自动结算失败");
						throw new ServiceException("体验订单中有产品的当前购买价格高于其体验押金，自动结算失败");
					}*/
                        BigDecimal differencePrice = experienceProduce.getPriceExperienceDeposit().subtract(experienceProduce.getPriceBuy());    // 产品押售差价
                        BigDecimal differenceMoney = differencePrice.multiply(new BigDecimal(experienceProduce.getBuyNum() == null ? experienceProduce.getNum() : experienceProduce.getBuyNum()));
                        srcReturnMoney = srcReturnMoney.add(differenceMoney);
                        // 更新体验产品状态为“体验结束”
                        experienceProduce.setStatus(ExperienceProduce.STATUS_FINISH);
                        experienceProduce.setExperienceOrder(experienceOrder);
                        experienceProduceService.save(experienceProduce);

                        if (experienceProduce.getBuyNum() != null && experienceProduce.getBuyNum().doubleValue() > 0){
                            messageCode = Notify.MSG_ORDER_DUE_FOR_NEW;
                        }

                        // 更新对应购买单状态为“交易完成”、支付状态为“支付完成”
                        BuyOrder buyOrder = experienceProduce.getDecisionBuyOrder();
                        buyOrder.setStatusMember(BuyOrder.STATUSMEMBER_FINISH);
                        buyOrder.setStatusSystem(BuyOrder.STATUSSYSTEM_FINISH);
                        buyOrder.setStatusPay(BuyOrder.STATUSPAY_PAID);
                        buyOrderMoney = buyOrderMoney.add(experienceProduce.getPriceBuy());
                        buyOrder.setMoneyTotal(buyOrderMoney.add(buyOrder.getMoneyLgt()).add(buyOrder.getMoneyAppointService()));
                        buyOrder.setMoneyPaid(buyOrderMoney.add(buyOrder.getMoneyLgt()).add(buyOrder.getMoneyAppointService()));
                        buyOrder.setMoneyProduce(buyOrderMoney);
                        buyOrderService.save(buyOrder);
                        break;
                    case ExperienceProduce.DECISIONTYPE_CHANGEBUY:    // 换
                        // 换货产品原产品应退押金金额累加
                        srcReturnMoney = srcReturnMoney.add(experienceProduce.getPriceExperienceDeposit().multiply(new BigDecimal(experienceProduce.getNum())));
                        // 换货产品原产品结算扣减金额累加
                        settlementDecMoney = settlementDecMoney.add(experienceProduce.getMoneySettDec());
                        // 换货产品原产品结算魅力豆可抵金额累加
                        settlementDecableBeansMoney = settlementDecableBeansMoney.add(experienceProduce.getMoneySettDecableBeans());
                        // 更新体验产品状态为“体验结束”
                        experienceProduce.setStatus(ExperienceProduce.STATUS_FINISH);
                        experienceProduce.setExperienceOrder(experienceOrder);
                        experienceProduceService.save(experienceProduce);
                        break;
                    case ExperienceProduce.DECISIONTYPE_APPOINTBUY:    // 预定
                        // 预定产品原产品应退金额累加
                        srcReturnMoney = srcReturnMoney.add(experienceProduce.getPriceExperienceDeposit().multiply(new BigDecimal(experienceProduce.getNum())));
                        // 预定产品原产品结算扣减金额累加
                        settlementDecMoney = settlementDecMoney.add(experienceProduce.getMoneySettDec());
                        // 预定产品原产品结算魅力豆可抵金额累加
                        settlementDecableBeansMoney = settlementDecableBeansMoney.add(experienceProduce.getMoneySettDecableBeans());
                        // 更新体验产品状态为“体验结束”
                        experienceProduce.setStatus(ExperienceProduce.STATUS_FINISH);
                        experienceProduce.setExperienceOrder(experienceOrder);
                        experienceProduceService.save(experienceProduce);
                        break;
                    default:
                        break;
                }
            }

            /**
             * 获取会员当前魅力豆及魅力豆兑换比例数据，计算可抵扣情况下魅力豆抵扣金额及消耗数量，更新抵扣后会员魅力豆(取消自动魅力豆抵扣)
             */
            // 会员当前魅力豆
            /*Beans beans = beansService.getByMemberIdForUpdate(experienceOrder.getMember().getId());
			// 魅力豆兑换比例
			Config besConfig = ConfigUtils.getConfig(Beans.BEANS_EXCHANGE_SCALE);
			BigDecimal besValue = besConfig.getConfigValue()==null ? null : BigDecimal.valueOf(Double.parseDouble(besConfig.getConfigValue().toString()));
			// 会员当前魅力豆，达到“结算魅力豆可抵金额”所需的魅力豆数量
			if(beans.getCurrentBeans() >= settlementDecableBeansMoney.divide(besValue, 0,BigDecimal.ROUND_UP).intValue()){
				// 计算抵扣金额及消耗数量
				settlementDecBeansMoney = settlementDecableBeansMoney;
				settlementDecBeansNum = settlementDecableBeansMoney.divide(besValue, 0,BigDecimal.ROUND_UP).intValue();
			}
			// 更新会员魅力豆
			if(settlementDecBeansNum != 0)
				beansDetailService.updateBalanceOperate(experienceOrder.getMember().getId(), BeansDetail.CHANGETYPE_DECREASE, settlementDecBeansNum, 
						experienceOrder.getOrderNo(), BeansDetail.CRT_D_SETTLEMENT_DEC);*/

            // 获取最终结算退款金额，退款金额 = 结算原始应退金额 - （结算扣减金额 - 魅力豆可抵金额） - 滞纳金 + 回程快递费用(无免责时为0) - 去程快递费用(免责时为0)+体验费
            if (overdueMoney.doubleValue() > 0) {
                messageCode = Notify.MSG_ORDER_OVERDUE_DEBT;
            }
            if(goableExpressMoney.compareTo(new BigDecimal("0.01")) == 0){
                goableExpressMoney = BigDecimal.ZERO;
            }
            returnMoney = srcReturnMoney.subtract(settlementDecMoney.subtract(settlementDecBeansMoney)).subtract(overdueMoney).add(returnableExpressMoney).subtract(goableExpressMoney).add(moneyExperience);
            returnMoney = returnMoney.setScale(2, BigDecimal.ROUND_HALF_UP);//两位小数四舍五入
            // 设置体验单结算资金信息
            experienceOrder.setMoneySettSrcReturn(srcReturnMoney);                    // 结算原始应退金额
            experienceOrder.setMoneySettDec(settlementDecMoney);                    // 结算扣减金额
            experienceOrder.setMoneySettDecableBeans(settlementDecableBeansMoney);    // 结算魅力豆可抵金额
            experienceOrder.setMoneySettDecBeans(BigDecimal.ZERO);            // 结算魅力豆抵扣金额
            experienceOrder.setNumSettDecBeans(0);                              // 结算魅力豆抵扣数量
            experienceOrder.setMoneySettOverdue(overdueMoney);                        // 结算滞纳金
            experienceOrder.setMoneySettReturn(returnMoney);                        // 结算退款金额
            experienceOrder.setSettlementTime(new Date());
            //如果退款金额未负数，说明押金不够扣除应付的金额
            logger.info("--------------结算订单信息："+experienceOrder.toString()+"-----------------");
            if (returnMoney.compareTo(BigDecimal.ZERO) == -1) {
                //取绝对值
                returnMoney = returnMoney.abs();
                ExperienceOrderDueTemp temp = new ExperienceOrderDueTemp();
                temp.setMoneySettDec(settlementDecMoney);
                temp.setMoneySettOverdue(overdueMoney);
                temp.setMoneySettReturn(srcReturnMoney);
                temp.setMoneySettSrcReturn(srcReturnMoney);                    // 结算原始应退金额
                temp.setMoneySettDecableBeans(settlementDecableBeansMoney);    // 结算魅力豆可抵金额
                temp.setMoneySettDecBeans(BigDecimal.ZERO);            // 结算魅力豆抵扣金额
                temp.setNumSettDecBeans(0);                // 结算魅力豆抵扣数量
                temp.setBuyOrderMoney(buyOrderMoney);
                temp.setArrearageAmount(returnMoney);
                temp.setOrderNo(experienceOrder.getOrderNo());
                temp.setMemberId(experienceOrder.getMember().getId());
                temp.setDamageType(isLightBroken);
                String json = JSONObject.fromObject(temp).toString();
                throw new ServiceException(json);
            }// 结算时间
        }

        /**
         * 3.执行退款（将实际应退金额 returnMoney 退回用户支付账户）
         * 微信退款调用orderPayService.experienceOrderRefund(experienceOrder, returnMoney)
         * 之前调用RefundService的退款方法，通过民生银行支付接口退款
         *
         */
        try {
            orderPayService.experienceOrderRefund(experienceOrder, returnMoney);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("------体验单自动结算，退款失败 refundService.refundByOrder()方法执行异常------");
        }

        /**
         * 4.更新体验单（结算资金信息、订单状态：已完成、评价状态：待评价）
         */
        experienceOrder.setStatusMember(ExperienceOrder.STATUSMEMBER_FINISH);
        experienceOrder.setStatusSystem(ExperienceOrder.STATUSSYSTEM_FINISH);
        experienceOrder.setStatusJudge(ExperienceOrder.STATUSJUDGE_TOJUDGE);
        this.save(experienceOrder);

        /**
         * 5.发送消息
         */
        logger.info("------------------损坏程度数值："+isLightBroken+"------------");
        if (StringUtils.isNotBlank(isLightBroken)){
            switch (isLightBroken){
                case QualityWorkordProduct.Dt_3:
                    messageCode = Notify.MSG_ORDER_DUE_FOR_NEW;
                    break;
                case QualityWorkordProduct.Dt_2:
                    messageCode = Notify.MSG_ORDER_DUE;
                    break;
                case QualityWorkordProduct.Dt_1:
                    messageCode = Notify.MSG_ORDER_SLIGHT_DAMAGE;
                    break;
                case QualityWorkordProduct.Dt_5:
                    messageCode = Notify.MSG_LOST_PART;
                    break;
                default:
                    break;
            }
        }


        if (StringUtils.isBlank(messageCode)) {
            messageCode = Notify.MSG_ORDER_SETTLE_AUTO;
        }

        if(Notify.MSG_ORDER_SLIGHT_DAMAGE.equals(messageCode)){
            memberNotifyService.createByNotifyCode(messageCode, experienceOrder.getMember(), experienceOrder.getOrderNo(), experienceOrder.getMoneySettDecableBeans());
        }else {
            memberNotifyService.createByNotifyCode(messageCode, experienceOrder.getMember(), experienceOrder.getOrderNo());
        }

//        if (Notify.MSG_ORDER_OVERDUE_DEBT.equals(messageCode)) {
//            memberNotifyService.createByNotifyCode(messageCode, experienceOrder.getMember(), experienceOrder.getOrderNo());
//        } else {
//        memberNotifyService.createByNotifyCode(messageCode, experienceOrder.getMember(),experienceOrder.getOrderNo());
//        }
    }

    /**
     * 查询订单所需支付金额
     *
     * @param experienceOrder
     * @return
     */
    public BigDecimal getExperienceOrderNeedPayMoney(ExperienceOrder experienceOrder) {
        BigDecimal moneyNeedPay = BigDecimal.ZERO;
        switch (experienceOrder.getStatusPay()) {
            case ExperienceOrder.STATUSPAY_TOPAY_APPOINT:
                moneyNeedPay = experienceOrder.getMoneyAppoint();
                break;
            case ExperienceOrder.STATUSPAY_TOPAY_FINAL:
                moneyNeedPay = experienceOrder.getMoneyTotal().subtract(experienceOrder.getMoneyAppoint());
                break;
            case ExperienceOrder.STATUSPAY_TOPAY_TOTAL:
                moneyNeedPay = experienceOrder.getMoneyTotal();
                break;
            default:
                throw new ServiceException("参数出错");
        }
        return moneyNeedPay;
    }


    public List<ExperienceOrder> findListByIds(List<String> ids) {
        return dao.findListByIds(ids);
    }


    /**
     * 订单取消
     *
     * @param experienceOrder
     */
    @Transactional(readOnly = false)
    public void updateStatus(ExperienceOrder experienceOrder) {
        // 更新订单状态
        super.save(experienceOrder);
    }

    /**
     * 订单取消,订单状态代发货=》退货中，退款，更新产品库存,更新发货单状态，相应货品的状态
     *
     * @param orderId
     */
    @Transactional(readOnly = false)
    public ExperienceOrder orderPass(String orderId) {
        ExperienceOrder experienceOrder = get(orderId);
        //校验订单状态,更新订单
        if (ExperienceOrder.STATUSSYSTEM_TOOUT.equals(experienceOrder.getStatusSystem())) {
            experienceOrder.setStatusSystem(ExperienceOrder.STATUSMEMBER_CLOSE);
            experienceOrder.setStatusMember(ExperienceOrder.STATUSSYSTEM_CLOSE);
            experienceOrder.setCloseType(ExperienceOrder.CLOSETYPE_STAFF);
            experienceOrder.setCloseTime(new Date());
            updateStatus(experienceOrder);
        } else {
            throw new ServiceException("警告：对应订单不允许取消，请联系管理员！");
        }

        //更新体验产品状态
        ExperienceProduce experienceProduce = new ExperienceProduce();
        experienceProduce.setExperienceOrder(experienceOrder);
        experienceProduce.setStatus(ExperienceProduce.STATUS_CLOSED);
        experienceProduceService.updateStatus(experienceProduce);

        //微信退款
        try {
            orderPayService.experienceOrderRefund(experienceOrder, experienceOrder.getMoneyPaid());
            //refundService.refundByOrder(experienceOrder.getMoneyPaid(), experienceOrder.getId());
        } catch (Exception e) {
            logger.info(e.toString());
        }

        //更新产品库存
        List<ExperienceProduce> experienceProduceList = experienceProduceService.getByExperienceOrder(orderId);
        for (ExperienceProduce produce : experienceProduceList) {
            WhProduce whProduce = whProduceService.getByProduce(produce.getProduce());
            whProduceService.updateWhProduceStock(whProduce.getWarehouse().getId(), whProduce.getProduce().getId(), "A", produce.getNum(), "D", produce.getNum(), "D", 0);
        }
        //取消发货单
        sendOrderService.refuseSendByOrder(orderId);

        return experienceOrder;
    }

    @Transactional(readOnly = false)
    public Integer getCountByMem(ExperienceOrder experienceOrder) {
        return dao.getCountByMem(experienceOrder);
    }

    /**
     * 货品全部遗失体验单转为购买
     * 1.生成购买单
     * 2.体验单自动结算
     * 3.更新产品库存
     *
     * @param orderId
     * @throws IOException
     * @throws ServiceException
     */
    @Transactional(readOnly = false)
    public ExperienceOrder experConvertBuy(String orderId) throws ServiceException, IOException {
        ExperienceOrder experienceOrder = get(orderId);
        List<ExperienceProduce> experienceProduceList = experienceProduceService.getByExperienceOrder(orderId);
        //因为报备类型改为全部遗失，所以这里不用判断是否只有一个商品
        if (experienceProduceList != null) {
            buyOrderService.createByExperienceOrder(experienceOrder);
        }


        return experienceOrder;
    }

    /**
     * 根据商品损坏类型获取回货质检登记损坏的订单数
     *
     * @param returnProduct
     */
    public Integer getDamageCount(ReturnProduct returnProduct, String memberId) {
        Map<String, Object> param = new HashMap<>();
        List<String> orderIds = returnProductService.getDamageCount(returnProduct);
        if (orderIds.size() <= 0) {
            return 0;
        }
        param.put("ids", orderIds);
        param.put("memberId", memberId);
        return dao.getDamageCount(param);
    }

    /**
     * 更新订单欠款状态
     *
     * @param experienceOrder
     */
    @Transactional(readOnly = false)
    public void updateDueStatus(ExperienceOrder experienceOrder) {
        // 更新订单状态
        dao.updateDueStatus(experienceOrder);
    }


    /**
     * 判断是否是首单
     * @param orderId
     * @return
     */
    public boolean isFirstOrder(String orderId){
        if (StringUtils.isBlank(orderId)){
            return false;
        }
        return orderId.equals(dao.isFirstOrder(get(orderId).getMember().getId()).getId());
    }

    /**
     * 获取用户交易信息
     * @param memberId
     * @return
     *          firstOrderTime 首单时间
     *          experienceTimes 体验次数
     *          experienceTotalMoney 体验商品总金额
     */
    public Map<String , Object> getMemberTradeInfo(String memberId){
        Map<String, Object> map = Maps.newHashMap();
        map.put("memberId", memberId);
        map.put("STATUSSYSTEM_CLOSE", ExperienceOrder.STATUSSYSTEM_CLOSE);
        return dao.getMemberTradeInfo(map);
    }

    /**
     * 查询用户首单
     * @param memberId
     * @return
     */
    public ExperienceOrder getFirstOrder(String memberId){
        Map<String, Object> map = Maps.newHashMap();
        map.put("memberId", memberId);
        map.put("STATUSSYSTEM_CLOSE", ExperienceOrder.STATUSSYSTEM_CLOSE);
        return dao.getFirstOrder(memberId);
    }
    /**
     * 根据订单取消到达预约体验日期、还未支付尾款的预约体验订单
     * @param experienceOrder
     * @return
     */
    @Transactional(readOnly = false)
    public void updateAppointToClose(ExperienceOrder experienceOrder){
        dao.updateAppointToClose(experienceOrder);
    }
    /**
     * 查询超期归还订单数
     * @param memberId
     * @return
     */
    public int countReturnOverDue(String memberId){
        Map<String, Object> map = Maps.newHashMap();
        map.put("memberId", memberId);
        map.put("STATUSSYSTEM_CLOSE", ExperienceOrder.STATUSSYSTEM_CLOSE);
        map.put("CONFIG_EXPERIENCEDAYS", ExperienceOrder.CONFIG_EXPERIENCEDAYS);
        return dao.countReturnOverDue(map);
    }


    /**
     * 快递确认送达，更新订单状态为已送达
     * @param orderNo				订单号
     * @param statuslogisticalSigned
     */
    @Transactional(readOnly=false)
    public void updateOrderStatusByExpress(Date realExpDate,String orderNo, String statuslogisticalSigned){
        dao.updateOrderStatusByExpress(realExpDate,orderNo, ExperienceOrder.STATUSSYSTEM_ARRIVED, statuslogisticalSigned);
    }

}