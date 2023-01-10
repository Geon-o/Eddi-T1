package team_project.buy_idea.service.product.qna;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.qna.AnswerStatus;
import team_project.buy_idea.entity.product.qna.QnA;
import team_project.buy_idea.entity.product.qna.QuestionCategory;
import team_project.buy_idea.repository.product.ProductRepository;
import team_project.buy_idea.repository.product.qna.QnARepository;

import java.util.Optional;

@Slf4j
@Service
public class QnAServiceImpl implements QnAService{

    @Autowired
    private QnARepository qnARepository;

    @Autowired
    private ProductRepository productRepository;

    /**
     * 문의 등록 ServiceImpl
     * @param request ProductNo, writer, questionCategory,
     *                questionTitle, questionContent, openStatus
     */
    public void register(QuestionRegisterRequest request){
        QnA qnA = new QnA();

        Optional<Product> maybeProduct = productRepository.findById(request.getProductNo());

        Product product;
        if(maybeProduct.isPresent()) {
            product = maybeProduct.get();
        } else {
            throw new RuntimeException("등록되지 않은 상품입니다.");
        }

        qnA.setWriter(request.getWriter());
        qnA.setProduct(product);
        qnA.setQuestionCategory(questionCategoryStringMapping(request.getQuestionCategory()));
        qnA.setQuestionTitle(request.getQuestionTitle());
        qnA.setQuestionContent(request.getQuestionContent());
        qnA.setAnswerStatus(AnswerStatus.BEFORE_ANSWER);
        qnA.setAnswer("");
        qnA.setOpenStatus(request.isOpenStatus());

        qnARepository.save(qnA);
    }

    /**
     * 문의 카테고리 String -> enum 변환 메서드
     * @param categoryName String 문의 카테고리
     * @return 문의카테고리 enum
     */
    public QuestionCategory questionCategoryStringMapping(String categoryName){

        return switch (categoryName) {
            case "상품 문의" -> QuestionCategory.PRODUCT_Q;
            case "배송 문의" -> QuestionCategory.DELIVERY_Q;
            case "교환 문의" -> QuestionCategory.EXCHANGE_Q;
            case "환불/취소 문의" -> QuestionCategory.REFUND_CANCEL_Q;
            case "기타" -> QuestionCategory.OTHER_Q;
            default -> null;
        };
    }
}