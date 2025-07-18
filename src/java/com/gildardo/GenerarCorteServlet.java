package com.gildardo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import okhttp3.*;
import org.json.JSONObject;

@WebServlet("/generar-corte")
public class GenerarCorteServlet extends HttpServlet {

    private static final String REPLICATE_API_URL = "https://api.replicate.com/v1/predictions";
    private static final String REPLICATE_API_TOKEN = "r8_61JzAQANK1G8G6KYclJXS2lqdAbrSrv2nUumC";
    private static final String MODEL_VERSION = "30c1d0b916a6f8efce20493f5d61ee27491ab2a60437c13c588468b9810ec23f";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        String contentType = request.getContentType();
        String imagenUrl = null;
        String corte = null;

        if (contentType != null && contentType.contains("application/json")) {
            BufferedReader reader = request.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            JSONObject jsonInput = new JSONObject(jsonBuilder.toString());
            imagenUrl = jsonInput.optString("imagenUrl", null);
            corte = jsonInput.optString("corte", null);
        } else {
            response.getWriter().write("{\"error\":\"Tipo de contenido no soportado\"}");
            return;
        }

        if (imagenUrl == null || corte == null || imagenUrl.isEmpty() || corte.isEmpty()) {
            response.getWriter().write("{\"error\":\"Faltan datos\"}");
            return;
        }

        // Traducimos el corte seleccionado al inglés
        String promptCorte = traducirCorteACorteIngles(corte);

        // ✅ Prompt mejorado para instruct-pix2pix: mantener imagen original y aplicar solo el corte
            String promptFinal = "Change the hairstyle to: " + promptCorte + ". Do not change anything else.";


        JSONObject requestBody = new JSONObject();
        requestBody.put("version", MODEL_VERSION);

        JSONObject input = new JSONObject();
        input.put("image", imagenUrl);
        input.put("prompt", promptFinal);
        input.put("guidance_scale", 7.5); // Fuerza de modificación
        input.put("num_inference_steps", 50); // Precisión (más pasos = mejor calidad)

        requestBody.put("input", input);

        OkHttpClient client = new OkHttpClient();

        RequestBody body = RequestBody.create(
            requestBody.toString(),
            MediaType.parse("application/json")
        );

        Request replicateRequest = new Request.Builder()
            .url(REPLICATE_API_URL)
            .header("Authorization", "Token " + REPLICATE_API_TOKEN)
            .header("Content-Type", "application/json")
            .post(body)
            .build();

        try (Response replicateResponse = client.newCall(replicateRequest).execute()) {
            if (!replicateResponse.isSuccessful()) {
                response.getWriter().write("{\"error\":\"No se pudo generar la imagen (fallo al iniciar predicción).\"}");
                return;
            }

            String json = replicateResponse.body().string();
            JSONObject jsonResponse = new JSONObject(json);
            String predictionId = jsonResponse.getString("id");

            // Esperar resultado
            String imageUrl = esperarResultado(client, predictionId);
            if (imageUrl != null) {
                response.getWriter().write("{\"estado\":\"ok\", \"imagenUrl\":\"" + imageUrl + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"No se pudo generar la imagen (predicción fallida).\"}");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write("{\"error\":\"Error interno\"}");
        }
    }

    private String esperarResultado(OkHttpClient client, String predictionId) throws InterruptedException, IOException {
        String url = REPLICATE_API_URL + "/" + predictionId;

        for (int i = 0; i < 40; i++) {
            Thread.sleep(3000); // 3 segundos entre cada intento

            Request checkRequest = new Request.Builder()
                .url(url)
                .header("Authorization", "Token " + REPLICATE_API_TOKEN)
                .get()
                .build();

            try (Response response = client.newCall(checkRequest).execute()) {
                String json = response.body().string();
                JSONObject result = new JSONObject(json);
                String status = result.getString("status");

                if ("succeeded".equals(status) && result.has("output")) {
                    return result.getJSONArray("output").getString(0);
                } else if ("failed".equals(status)) {
                    return null;
                }
            }
        }

        return null;
    }

    private String traducirCorteACorteIngles(String corte) {
        switch (corte.toLowerCase()) {
            case "fade moderno":
                return "modern fade haircut";
            case "undercut clásico":
                return "classic undercut";
            case "corte con flequillo":
                return "haircut with bangs";
            case "estilo pompadour":
                return "pompadour hairstyle";
            case "corte buzz":
                return "buzz cut";
            default:
                return "modern hairstyle";
        }
    }
}
