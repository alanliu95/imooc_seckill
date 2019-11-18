package service;

import com.imooc.miaosha.MainApplication;
import com.imooc.miaosha.service.GoodsService;
import com.imooc.miaosha.service.MiaoshaService;
import com.imooc.miaosha.vo.GoodsVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.concurrent.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = MainApplication.class)
public class MiaoshaServiceTest implements Runnable{
    @Autowired
    MiaoshaService miaoshaService;

    public static int THREAD_NUM=1000;
    @Test
    public void hello() throws  InterruptedException {
        System.out.println("hello");
        ExecutorService pool = Executors.newCachedThreadPool();
        ArrayList<Future> futures = new ArrayList<Future>();
        for (int i = 0; i < THREAD_NUM; i++) {
            futures.add(pool.submit(this));
        }
        pool.shutdown();
        pool.awaitTermination(10, TimeUnit.SECONDS);

    }

    @Autowired
    GoodsService goodsService;
    @Override
    public void run() {
        GoodsVo goodsVo=new GoodsVo();
        goodsVo.setId(1l);
        goodsService.reduceStock(goodsVo);
    }
}
