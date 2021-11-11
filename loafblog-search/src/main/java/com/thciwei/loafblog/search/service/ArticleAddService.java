package com.thciwei.loafblog.search.service;

import com.thciwei.common.to.es.ArticleEsModel;

import java.io.IOException;


public interface ArticleAddService {

    Boolean addArticle(ArticleEsModel articleEsModels) throws IOException;
}
