#pragma once
#include "vDrawableComponent.h"

using namespace vEngine;

namespace vEngine
{
	class Mesh;
}


namespace Rendering {
	class TexturedModel : public DrawableComponent {
		RTTI_DECLARATIONS(TexturedModel, DrawableComponent)
	public:
		TexturedModel(Engine& game, Camera& camera);
		~TexturedModel();

		virtual void Initialize() override;
		virtual void Draw(const Time& gameTime) override;

	private:
		typedef struct _TextureMappingVertex
		{
			XMFLOAT4 Position;
			XMFLOAT2 TextureCoordinates;

			_TextureMappingVertex() { }

			_TextureMappingVertex(XMFLOAT4 position, XMFLOAT2 textureCoordinates)
				: Position(position), TextureCoordinates(textureCoordinates) { }
		} TextureMappingVertex;

		TexturedModel();
		TexturedModel(const TexturedModel& rhs);
		TexturedModel& operator=(const TexturedModel& rhs);

		void CreateVertexBuffer(ID3D11Device* device, const Mesh& mesh, ID3D11Buffer** vertexBuffer) const;

		ID3DX11Effect* mEffect;
		ID3DX11EffectTechnique* mTechnique;
		ID3DX11EffectPass* mPass;
		ID3DX11EffectMatrixVariable* mWvpVariable;
		ID3D11ShaderResourceView* mTextureShaderResourceView;
		ID3DX11EffectShaderResourceVariable* mColorTextureVariable;
		ID3D11InputLayout* mInputLayout;
		ID3D11Buffer* mVertexBuffer;
		ID3D11Buffer* mIndexBuffer;
		UINT mIndexCount;
		XMFLOAT4X4 mWorldMatrix;
	};
}